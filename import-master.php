<?php
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

define('DEBUG', true);

try {
  $database = new medoo($settings);
} catch (Exception $e) {
  $message = 'I cannot connect to the database!' ."\n" . '- Is MySQL running?' ."\n" . '- Do you have the right username and password?' ."\n" . '- Does a database named "'.$settings['database_name'].'"  exist?' . "\n\n" . 'Connection settings are:' . "\n\n";
  $message .= print_r($settings, true);

  die($message);
}


echo 'Starting' . "\n\n";

$file_path = 'data/-master-list.xml';
$file_handle = fopen( join('/', array(__DIR__, $file_path)), 'r');
$file_data = fread($file_handle, filesize( join('/', array(__DIR__, $file_path))));

$xml_data = simplexml_load_string($file_data);

foreach ($xml_data as $system) {
  if (in_array($system['shortcode'], $systems_to_import)) {
    $source_path = join('/', array($media_path['source'], $system['shortcode']));
    $destination_path = $media_path['destination'];

    if (IMPORT_MEDIA == true) {
      if (
        !isset($destination_path)
        || !is_writable($destination_path)
      ) {
        throw new Exception('Array `media_path["destination"]` is not found or writable: ' . $destination_path);
      }


      if ( !isset($source_path) ) {
        throw new Exception('Array `media_path["source"]` is not found or writable: ' .$source_path);
      }
    }

    foreach ($system as $game) {

      // Create a Game entry, no need to check if this
      // game exists already since the database is empty.
      $last_game_id = $database->insert(TBL_GAME, [
        'description' => (string) $game->cartridge->title,
        'disabled' => NO,
      ]);
      check_database_error($database);


      // Associating Genres with current game.
      foreach ($game->genres as $genre) {
        $last_genre_id = get_genre_id((string) $genre->genre, $database, true);
        $database->insert(TBL_GAME_GENRE, [
          'genre_type_id' => $last_genre_id,
          'game_id' => $last_game_id,
        ]);
        check_database_error($database);
      }

      // Associating "Cartridges" with current game.
      foreach ($game->cartridge as $cartridge) {
        $title = (string) $cartridge->title;
        $region_type_id = get_region_id($cartridge->region, $database, true);
        $game_default = (!empty($cartridge['primary']) && 'Y' == $cartridge['primary']) ?  YES : NO;
        $license = truthy($cartridge->license);
        $demo = truthy($cartridge->demo);
        $prototype = truthy($cartridge->prototype);
        $special = truthy($cartridge->special);

        $last_cartridge_id = $database->insert(TBL_CARTRIDGE, [
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
          $console_id = get_console_id($console->console, $database, true);
          $database->insert(TBL_CARTRIDGE_CONSOLE, [
            'console_id' => (int) $console_id,
            'cartridge_id' => (int) $last_cartridge_id,
          ]);
          check_database_error($database);
        }

        // Associating Companies
        // companies are processed after cartridge insert
        foreach ($cartridge->companies as $company) {
          $company_role_type_id = get_type((string) $company->company['type'], CREATION_ROLE, $database, false);
          $company_id = get_company_id($company->company, $database, true);
          $database->insert(TBL_CARTRIDGE_COMPANY, [
            'company_id' => (int) $company_id,
            'cartridge_id' => (int) $last_cartridge_id,
            'company_role_type_id' => (int) $company_role_type_id,
          ]);
          check_database_error($database);
        }

        // Associating Releases
        // releases are processed after cartridge insert
        foreach ($cartridge->releases as $release) {
          $country_type_id = get_type((string) $release->release->country, COUNTRIES, $database, true);
          $maturity_rating_type_id = get_maturity_rating_id($release->release->rating, $database, false);
          $is_official_release = truthy($release->release->offical);
          $quantities_shipped = $release->release->shipped;
          $release_date = $release->release->release_date;

          $last_release_id = $database->insert(TBL_RELEASE, [
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

            $last_media_id = $database->insert(TBL_MEDIA, [
              'foreign_id' => $last_release_id,
              'foreign_type' => $foreign_type,
              'file_name' => $file_name,
              'role' => $role,
              'mime_type' => $mime_type,
              'description' => $description,
            ]);
            check_database_error($database);

            if (IMPORT_MEDIA == true) {
              $full_source_path = join('/', array($source_path, $file_name));

              $full_destination_folder = implode('/', [$media_path['destination'], 'game', 'release', $last_release_id]);
              if(!file_exists($full_destination_folder)) {
                $r = mkdir($full_destination_folder, 0766, TRUE);
              }
              $full_destination_path = implode('/', [$full_destination_folder, $file_name]);
              rename($full_source_path, $full_destination_path);
            }
          }
        }
      }
    }
  }
}

echo 'Finished!';
