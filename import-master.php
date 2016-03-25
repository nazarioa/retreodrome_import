<?php
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

$database = new medoo ($settings);
define ('DEBUG', true);

$file_path = 'temp.bk.xml';
$file_handle = fopen ( __DIR__ . '/' . $file_path, 'r');
$file_data = fread ($file_handle, filesize (__DIR__ . '/' . $file_path));

$xml_data = simplexml_load_string ($file_data);

$final_results = array ();

foreach ($xml_data->game as $game) {

  $last_game_id = $database->insert ('games', [
    'description' => (string) $game->title,
    'disabled' => NO,
  ]);

  // Associating Genres
  foreach ($game->genres as $genre) {
    $last_genre_id = get_genre ($genre->genre, $database, true);
    $database->insert ('games_genres', [
      'genre_type_id' => $last_genre_id,
      'game_id' => $last_game_id,
    ]);
  }

  // Associating Cartridges
  foreach ($game->cartridge as $cartridge) {
    $title = $cartridge->title;
    $region_type_id = get_region_id ($cartridge->region, $database, true);
    $maturity_rating_type_id = get_maturity_rating_id ($cartridge->rating, $database, true);
    $game_default = ( !empty ($cartridge['primary']) && 'Y' == $cartridge['primary'] ) ?  YES : NO;

    $last_cartridge_id = $database->insert ('cartridges', [
      'game_id' => (int) $last_game_id,
      'name' => (string) $title,
      'region_type_id' => (int) $region_type_id,
      'maturity_rating_type_id' => (int) $maturity_rating_type_id,
      'game_default' => (int) $game_default,
      'disabled' => NO,
    ]);

    // Associating Boaxart
    // boaxart are processed after cartridge insert

    // Associating Consoles
    // consoles are processed after cartridge insert

    // Associating Companies
    // companies are processed after cartridge insert

    // Associating Releases
    // releases are processed after cartridge insert
  }
}

echo PHP_EOL;
print_r ($final_results);

?>
