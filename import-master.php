<?php
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

$database = new medoo ($settings);
define ('DEBUG', true);

$file_path = 'data/-master-list.xml';
$file_handle = fopen ( __DIR__ . '/' . $file_path, 'r');
$file_data = fread ($file_handle, filesize (__DIR__ . '/' . $file_path));

$xml_data = simplexml_load_string ($file_data);

foreach ($xml_data as $game) {

  // Create a Game entry, no need to check if this
  // game exists already since the database is empty.
  $last_game_id = $database->insert ('games', [
    'description' => (string) $game->cartridge->title,
    'disabled' => NO,
  ]);
  check_database_error($database);


  // Associating Genres with current game.
  foreach ($game->genres as $genre) {
    $last_genre_id = get_genre_id ($genre->genre, $database, true);
    $database->insert (TBL_GAME_GENRE, [
      'genre_type_id' => $last_genre_id,
      'game_id' => $last_game_id,
    ]);
    check_database_error($database);
  }

  // Associating "Cartridges" with current game.
  foreach ($game->cartridge as $cartridge) {
    $title = (string) $cartridge->title;
    $region_type_id = get_region_id ($cartridge->region, $database, true);
    $game_default = ( !empty ($cartridge['primary']) && 'Y' == $cartridge['primary'] ) ?  YES : NO;
    $license = truthy ($cartridge->license);
    $demo = truthy ($cartridge->demo);
    $prototype = truthy ($cartridge->prototype);
    $special = truthy ($cartridge->special);

    $last_cartridge_id = $database->insert (TBL_CARTRIDGE, [
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
    check_database_error($database);

    // Associating Consoles
    // consoles are processed after cartridge insert
    foreach ($cartridge->consoles as $console) {
      $console_id = get_console_id ($console->console, $database, true);
      $database->insert (TBL_CARTRIDGE_CONSOLE, [
        'console_id' => (int) $console_id,
        'cartridge_id' => (int) $last_cartridge_id,
      ]);
      check_database_error($database);
    }

    // Associating Companies
    // companies are processed after cartridge insert
    foreach ($cartridge->companies as $company) {
      $company_role_type_id = get_type ( (string) $company->company['type'], CREATION_ROLE, $database, false);
      $company_id = get_company_id ( $company->company, $database, true);
      $database->insert (TBL_CARTRIDGE_COMPANY, [
        'company_id' => (int) $company_id,
        'cartridge_id' => (int) $last_cartridge_id,
        'company_role_type_id' => (int) $company_role_type_id,
      ]);
      check_database_error($database);
    }

    // Associating Releases
    // releases are processed after cartridge insert
    foreach ($cartridge->releases as $release) {
      echo($release->rating);

      $country_type_id = get_type ($release->release->country, COUNTRIES, $database, true);
      $maturity_rating_type_id = get_maturity_rating_id ($release->release->rating, $database, false);
      $is_official_release = truthy ($release->release->offical);
      $quantities_shipped = $release->release->shipped;
      $release_date = $release->release->release_date;

      $last_release_id = $database->insert (TBL_RELEASE, [
        'cartridge_id' => (int) $last_cartridge_id,
        'country_type_id' => (int) $country_type_id,
        'maturity_rating_type_id' => (int) $maturity_rating_type_id,
        'release_date' => (string) $release_date,
        'is_official_release' => (int) $is_official_release,
        'quantities_shipped' => (int) $quantities_shipped,
      ]);
      check_database_error($database);

      // Associating Boaxart
      // boaxart are processed after cartridge insert
      // TODO: Box Art / Database design for it.
      foreach ($release->release->boxart->media as $media) {
        $file_name = (string) $media;
        $foreign_type = (string) $media['foreign_type'];
        $role = (string) $media['role'];
        $mime_type = (string) $media['mime'];
        $description = $foreign_type . '-' . $role . '-' . $file_name;

        $last_media_id = $database->insert (TBL_MEDIA, [
          'foreign_id' => $last_release_id,
          'foreign_type' => $foreign_type,
          'file_name' => $file_name,
          'role' => $role,
          'mime_type' => $mime_type,
          'description' => $description,
        ]);
        check_database_error($database);
      }
    }
  }
}
?>
