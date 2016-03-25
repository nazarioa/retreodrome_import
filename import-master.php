<?php
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

$database = new medoo ($settings);
define ('DEBUG', true);
define ('CONSOLEID', 3);

define ('MECHANICS', 'Mechanics');
define ('GENRES', 'Genres');
define ('MATURITY_RATING', 'Maturity Rating');
define ('CREATION_ROLE', 'Creation Role');
define ('REGIONS', 'Regions');
define ('OTHER', 'Other');
define ('COUNTRIES', 'Countries');

$file_path = 'temp.bk.xml';
$file_handle = fopen ( __DIR__ . '/' . $file_path, 'r');
$file_data = fread ($file_handle, filesize (__DIR__ . '/' . $file_path));

$xml_data = simplexml_load_string ($file_data);

$final_results = array ();

foreach ($xml_data->game as $game) {

  foreach ($game as $key => $cartridge) {

    $releaseData = $database->select ('releases', ['id', 'game_id'], ['name' => (string) $cartridge->title]);

    if (!empty ($releaseData)) {
      // Releases by this name exists
      $final_results[] = 'Release for this title exists:' . (string) $cartridge->title;
    } else {

      try {
        $region_id = get_region_id ( (string) $cartridge->region, $database);

      } catch (Exception $e) {
        if ($e->getMessage () == RESULTS_ZERO) {
          $region_id = 1;

        } else {
          throw $e;
        }
      }

      try {
        $company_id = get_company_id ( (string) $cartridge->manufacturer, $database);
      } catch (Exception $e) {
        if ($e->getMessage () == RESULTS_ZERO) {
          $company_id = $database->insert ('companies', ['name' => (string) $cartridge->manufacturer]);
          $final_results[] = 'Added a new company: ' . $cartridge->manufacturer;
        } else {
          throw $e;
        }
      }

      try {
        $maturity_rating_type_id = get_maturity_rating_id ( (string) $cartridge->rating, $database);
      } catch (Exception $e) {
        if ($e->getMessage () == RESULTS_ZERO) {
          $maturity_rating_type_id = $database->insert ('types', ['name' => (string) $cartridge->rating, 'category_id' => 4]);
          $final_results[] = 'Added a new rating: ' . $cartridge->rating;
        } else {
          throw $e;
        }
      }

      try {
        $genre_id = get_genre_id ( (string) $cartridge->genre, $database);
      } catch (Exception $e) {
        if ($e->getMessage () == RESULTS_ZERO) {
          $genre_id = $database->insert ('types', ['name' => (string) $cartridge->genre, 'category_id' => 3]);
          $final_results[] = 'Added a new genre: ' . $cartridge->genre;
        } else {
          throw $e;
        }
      }

      if (DEBUG == true) {
        $last_game_id = $database->debug ()->insert ('games', [
          'description' => (string) $cartridge->title,
        ]);

        $last_games_genres = $database->debug ()->insert ('games_genres', [
          'genre_type_id' => get_genre_id ( (string) $cartridge->genre, $database),
          'game_id' => (int) $last_game_id,
        ]);

        $last_releases_id = $database->debug ()->insert ('releases', [
          'name' => (string) $cartridge->title,
          'game_id' => (int) $last_game_id,
          'region_type_id' => (int) $region_id,
          'maturity_rating_type_id' => (int) $maturity_rating_type_id,
          'release_date' => (string) $entry->year,
        ]);

        $last_companies_releases = $database->debug ()->insert ('companies_releases', [
          'release_id' => (int) $last_releases_id,
          'company_id' => (int) $company_id,
          'company_role_type_id' => 65,
        ]);
      }
      else {
        $last_game_id = $database->insert ('games', [
          'description' => (string) $entry->title,
        ]);

        $last_games_genres = $database->insert ('games_genres', [
          'genre_type_id' => get_genre_id ( (string) $cartridge->genre, $database),
          'game_id' => (int) $last_game_id,
        ]);

        $last_releases_id = $database->insert ('releases', [
          'name' => (string) $cartridge->title,
          'game_id' => (int) $last_game_id,
          'region_type_id' => (int) $region_id,
          'maturity_rating_type_id' => (int) $maturity_rating_type_id,
          'release_date' => (string) $entry->year,
          'prototype' => (int) $cartridge->prototype,
          'unlicensed' => (int) $cartridge->unlicensed,
        ]);

        $last_companies_releases = $database->insert ('companies_releases', [
          'release_id' => (int) $last_releases_id,
          'company_id' => (int) $company_id,
          'company_role_type_id' => 65,
        ]);

        $database->insert ('consoles_releases', [
          'console_id' => (int) CONSOLEID,
          'release_id' => (int) $last_releases_id,
        ]);
      }
    }
  }
}

echo PHP_EOL;
print_r ($final_results);


// Helper functions

function get_region_id ($name, &$database, $insert = false) {
  try {
    $region_id = get_type ($name, REGIONS, $database);
  } catch (Exception $e) {
    if ($e->messsage == RESULTS_ZERO && $insert == true) {
      $region_id = set_region_id ($name, $database);
    } else {
      throw $e;
    }
  }

  return $region_id;
}

function set_region_id ($name, &$database) {
  return set_type ($name, REGIONS, $database);
}


function get_maturity_rating_id ($name, &$database, $insert = false) {
  try {
    $maturity_rating_type_id = get_type ($name, MATURITY_RATING, $database);
  } catch (Exception $e) {
    if ($e->messsage == RESULTS_ZERO && $insert == true) {
      $maturity_rating_type_id = set_maturity_rating_id ($name, $database);
    } else {
      throw $e;
    }
  }

  return $maturity_rating_type_id;
}

function set_maturity_rating_id ($name, &$database) {
  return set_type ($name, MATURITY_RATING, $database);
}


function get_mechanics_id ($name, &$database, $insert = false) {
  try {
    $mechanics_id = get_type ($name, MECHANICS, $database);
  } catch (Exception $e) {
    if ($e->messsage == RESULTS_ZERO && $insert == true) {
      $mechanics_id = set_mechanics_id ($name, $database);
    } else {
      throw $e;
    }
  }

  return $mechanics_id;
}

function set_mechanics_id ($name, &$database) {
  return set_type ($name, MECHANICS, $database);
}


function get_genre_id ($name, &$database, $insert = false) {
  try {
    $genre_id = get_type ($name, GENRES, $database);
  } catch (Exception $e) {
    if ($e->messsage == RESULTS_ZERO && $insert == true) {
      $genre_id = set_genre_id ($name, $database);
    } else {
      throw $e;
    }
  }

  return $genre_id;
}

function set_genre_id ($name, &$database) {
  return set_type ($name, GENRES, $database);
}


function get_company_id ($name, &$database, $insert = false) {
  $company_id = $database->select ('companies', ['id'], ['name [~]' => (string) $name]);

  if ( count ($company_id) == 1) {
    return $company_id[0]['id'];
  } elseif (DEBUG == true) {
    return 1;
  } elseif ( count ($company_id) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif ( count ($company_id) < 1 ) {
    $company_id = set_company_id ($name, $database);
  }

  return $company_id;
}

function set_company_id ($name, &$database) {
  $company_id = $database->insert ('companies', [
    'name' => (string) $name,
  ]);
  return $company_id;
}


function get_type ($type_name, $category_name, &$database, $insert = false) {
  try {
    $category = get_category ($category_name, $database);
  } catch (Exception $e) {
    throw new Exception (RESULTS_INVALID, 1);
  }

  $type = $database->select ('types', ['id'], ['and' => ['category_id [=]' => $category['id'], 'name [~]' => (string) $type_name]]);

  if (count ($type) == 1) {
    return $type[0]['id'];
  } elseif (DEBUG == true) {
    return 1;
  } elseif (count ($type) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif (count ($type) < 1 ) {
    throw new Exception (RESULTS_ZERO, 1);
  }

  throw new Exception (RESULTS_INVALID, 1);
}

function set_type ($name, $category, &$database) {
  try {
    $category_id = get_category($category, $database);
  } catch (Exception $e) {
    throw $e;
  }

  $type_id = $database->insert ('types', [
    'name' => (string) $name,
    'category_id' => (int) $category_id,
  ]);

  return $type_id;
}

function get_category ($category_name, &$database) {
  $category_id = $database->select ('categories', ['id'], ['name [~]' => (string) $category_name, ]);

  if ( count ($category_id) == 1) {
    return $category_id[0];
  } elseif (DEBUG == true) {
    return 1;
  }elseif ( count ($category_id) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif ( count ($category_id) < 1 ) {
    throw new Exception (RESULTS_ZERO, 1);
  }

  throw new Exception (RESULTS_INVALID, 1);
}
?>
