<?php
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

$database = new medoo ($settings);
define ('DEBUG', true);

$file_path = 'data/-master-list-2.xml';
$file_handle = fopen ( __DIR__ . '/' . $file_path, 'r');
$file_data = fread ($file_handle, filesize (__DIR__ . '/' . $file_path));

$xml_data = simplexml_load_string ($file_data);

$final_results = array ();

foreach ($xml_data as $game) {

  // Create a Game entry, no need to check if this
  // game exists already since the database is empty.
  $last_game_id = $database->insert ('games', [
    'description' => (string) $game->title,
    'disabled' => NO,
  ]);

  // Associating Genres with current game.
  foreach ($game->genres as $genre) {
    $last_genre_id = get_genre ($genre->genre, $database, true);
    $database->insert ('games_genres', [
      'genre_type_id' => $last_genre_id,
      'game_id' => $last_game_id,
    ]);
  }

  // Associating "Cartridges" with current game.
  foreach ($game->cartridge as $cartridge) {
    $title = $cartridge->title;
    $region_type_id = get_region_id ($cartridge->region, $database, true);
    $game_default = ( !empty ($cartridge['primary']) && 'Y' == $cartridge['primary'] ) ?  YES : NO;
    $license = truthy ($cartridge->license);
    $demo = truthy ($cartridge->demo);
    $prototype = truthy ($cartridge->prototype);
    $special = truthy ($cartridge->special);

    $last_cartridge_id = $database->insert ('cartridges', [
      'game_id' => (int) $last_game_id,
      'region_type_id' => (int) $region_type_id,
      'name' => (string) $title,
      'game_default' => (int) $game_default,
      'disabled' => NO,
      'license' => (int) $license,
      'demo' => (int) $demo,
      'prototype' => (int) $prototype,
      'special' => (int) $special,
    ]);

    // Associating Boaxart
    // boaxart are processed after cartridge insert
    // TODO: Box Art / Database design for it.

    // Associating Consoles
    // consoles are processed after cartridge insert
    foreach ($consoles as $console) {
      $console_id = get_console_id ($console->console, $database, true);
      $database->insert ('cartridges_consoles', [
        'console_id' => (int) $console_id,
        'cartridge_id' => (int) $last_cartridge_id,
      ]);
    }

    // Associating Companies
    // companies are processed after cartridge insert
    foreach ($companies as $company) {
      $company_role_type_id = get_type ( (string) $company['type'], CREATION_ROLE, $database, true);
      $company_id = get_company_id ($company->company, $database, true);
      $database->insert ('cartridges_consoles', [
        'console_id' => (int) $console_id,
        'cartridge_id' => (int) $last_cartridge_id,
        'company_role_type_id' => (int) $company_role_type_id,
      ]);
    }

    // Associating Releases
    // releases are processed after cartridge insert
    foreach ($releases as $release) {
      $country_type_id = get_type ( (string) $release->country, COUNTRIES, $database, true);
      $maturity_rating_type_id = get_maturity_rating_id ($release->rating, $database, true);
      $is_official_release = truthy ($release->offical);
      $quantities_shipped = (int) $release->shipped;

      $last_release_id = $database->insert ('release', [
        'cartridge_id' => (int) $last_cartridge_id,
        'country_type_id' => (int) $country_type_id,
        'maturity_rating_type_id' => (int) $maturity_rating_type_id,
        'is_official_release' => (int) $is_official_release,
        'release_date' => (string) $release->release_date,
        'quantities_shipped' => (int) $quantities_shipped,
      ]);

      foreach ($release->boxart as $media) {
        $last_media_id = $database->insert ('media', [
          'foreign_id ' => (int) $last_release_id,
          'foreign_type ' =>  $media['foreign_type'],
          'file_name ' => (string) $media,
          'role ' => $media['role'],
          'mime_type ' => $media['mime'],
        ]);
      }
    }
  }
}

echo PHP_EOL;
print_r ($final_results);

?>
