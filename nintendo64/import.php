<?php
require_once __DIR__ . '/../sensitive-settings.php';
require_once __DIR__ . '/../common.php';
require_once __DIR__ . '/../Medoo/medoo.php';

$database = new medoo ($settings);
define ('DEBUG', false);

$file_path = 'data-64-complete.xml';
$file_handle = fopen ( __DIR__ . '/' . $file_path, 'r');
$file_data = fread ($file_handle, filesize (__DIR__ . '/' . $file_path));

$xml_data = simplexml_load_string ($file_data);

$final_results = array ();

foreach ($xml_data->game as $key => $entry) {
  $release = $database->select ('releases', ['id', 'game_id'], ['name' => (string) $entry->title]);

  if (!empty ($release)) {
    // Releases by this name exists
    $final_results[] = 'Release for this title exists:' . (string) $entry->title;
  } else {

    try {
      $region_id = get_region_id ( (string) $entry->region, $database);

    } catch (Exception $e) {
      if ($e->getMessage () == RESULTS_ZERO) {
        $region_id = 1;

      } else {
        throw $e;
      }
    }

    try {
      $company_id = get_company_id ( (string) $entry->manufacturer, $database);
    } catch (Exception $e) {
      if ($e->getMessage () == RESULTS_ZERO) {
        $company_id = $database->insert ('companies', ['name' => (string) $entry->manufacturer]);
        $final_results[] = 'Added a new company: ' . $entry->manufacturer;
      } else {
        throw $e;
      }
    }

    try {
      $maturity_rating_type_id = get_maturity_rating_id ( (string) $entry->rating, $database);
    } catch (Exception $e) {
      if ($e->getMessage () == RESULTS_ZERO) {
        $maturity_rating_type_id = $database->insert ('types', ['name' => (string) $entry->rating, 'category_id' => 4]);
        $final_results[] = 'Added a new rating: ' . $entry->rating;
      } else {
        throw $e;
      }
    }

    try {
      $genre_id = get_genre_id ( (string) $entry->genre, $database);
    } catch (Exception $e) {
      if ($e->getMessage () == RESULTS_ZERO) {
        $genre_id = $database->insert ('types', ['name' => (string) $entry->genre, 'category_id' => 3]);
        $final_results[] = 'Added a new genre: ' . $entry->genre;
      } else {
        throw $e;
      }
    }

    if (DEBUG == true) {
      $last_game_id = $database->debug ()->insert ('games', [
        'description' => (string) $entry->title,
      ]);

      $last_games_genres = $database->debug ()->insert ('games_genres', [
        'genre_type_id' => get_genre_id ( (string) $entry->genre, $database),
        'game_id' => (int) $last_game_id,
      ]);

      $last_releases_id = $database->debug ()->insert ('releases', [
        'name' => (string) $entry->title,
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
        'genre_type_id' => get_genre_id ( (string) $entry->genre, $database),
        'game_id' => (int) $last_game_id,
      ]);

      $last_releases_id = $database->insert ('releases', [
        'name' => (string) $entry->title,
        'game_id' => (int) $last_game_id,
        'region_type_id' => (int) $region_id,
        'maturity_rating_type_id' => (int) $maturity_rating_type_id,
        'release_date' => (string) $entry->year,
      ]);

      $last_companies_releases = $database->insert ('companies_releases', [
        'release_id' => (int) $last_releases_id,
        'company_id' => (int) $company_id,
        'company_role_type_id' => 65,
      ]);
    }
  }

}
echo PHP_EOL;
print_r ($final_results);


// Helper functions

function get_region_id ($name, &$database) {
  return get_type ($name, 'Regions', $database);
}


function get_maturity_rating_id ($name, &$database) {
  return get_type ($name, 'Maturity Rating', $database);
}


function get_mechanics_id ($name, &$database) {
  return get_type ($name, 'Mechanics', $database);
}


function get_genre_id ($name, &$database) {
  return get_type ($name, 'Genres', $database);
}


function get_type ($type_name, $category_name, &$database) {
  try {
    $category = get_category ($category_name, $database);
  } catch (Exception $e) {
    throw new Exception (RESULTS_INVALID, 1);
  }

  $type = $database->select ('types', ['id'], ['and' => ['category_id [=]' => $category['id'], 'name' => (string) $type_name]]);

  if (count ($type) == 1) {
    return $type[0]['id'];
  } elseif (count ($type) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif (count ($type) < 1 ) {
    throw new Exception (RESULTS_ZERO, 1);
  }

  throw new Exception (RESULTS_INVALID, 1);
}


function get_category ($category_name, &$database) {
  $category_id = $database->select ('categories', ['id'], ['name [=]' => (string) $category_name, ]);

  if ( count ($category_id) == 1) {
    return $category_id[0];
  }elseif ( count ($category_id) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif ( count ($category_id) < 1 ) {
    throw new Exception (RESULTS_ZERO, 1);
  }

  throw new Exception (RESULTS_INVALID, 1);
}

function get_company_id ($name, &$database) {
  $company_id = $database->select ('companies', ['id'], ['name [=]' => (string) $name]);

  if ( count ($company_id) == 1) {
    return $company_id[0]['id'];
  } elseif ( count ($company_id) > 1) {
    throw new Exception (RESULTS_MULTIPLE, 1);
  } elseif ( count ($company_id) < 1 ) {
    throw new Exception (RESULTS_ZERO, 1);
  }
}
?>
