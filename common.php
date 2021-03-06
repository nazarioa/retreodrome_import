<?php
namespace Retrodrome\Import;

use Medoo\Medoo;

require_once __DIR__ . '/sensitive-settings.php';
define('RESULTS_MULTIPLE', 'Found >1');
define('RESULTS_ZERO', 'Found 0');
define('RESULTS_INVALID', 'Invalid Results');

// __Category Names__
define('MECHANICS', 'Mechanic');
define('GENRES', 'Genre');
define('MATURITY_RATING', 'Maturity Rating');
define('CREATION_ROLE', 'Creation Role');
define('REGIONS', 'Region');
define('OTHER', 'Other');
define('COUNTRIES', 'Country Code');

// __Table Names__
define('TBL_TYPE', 'types');
define('TBL_CATEGORY', 'categories');
define('TBL_COMPANY', 'companies');
define('TBL_CONSOLE', 'consoles');
define('TBL_CARTRIDGE', 'cartridges');
define('TBL_CARTRIDGE_CONSOLE', 'cartridges_consoles');
define('TBL_CARTRIDGE_COMPANY', 'cartridges_companies');
define('TBL_MEDIA', 'media');
define('TBL_GAME', 'games');
define('TBL_GAME_GENRE', 'games_genres');
define('TBL_RELEASE', 'releases');

define('YES', 1);
define('NO', 0);
define('DEFAULT_TYPE', 1);

define('NO_COUNTRY', 'ZZZ');
define('ALL_COUNTRY', 'ALL');


// Helper functions

function get_region_id($name, &$database, $insert = FALSE) {
  try {
    $region_id = get_type($name, REGIONS, $database);
  } catch (\Exception $e) {
    if ($e->getMessage() == RESULTS_ZERO && $insert == TRUE) {
      $region_id = set_region_id($name, $database);
    }
    else {
      throw new \Exception($e->getMessage() . "\n\n" . $database->last());
    }
  }

  return $region_id;
}

function set_region_id($name, &$database) {
  return set_type($name, REGIONS, $database);
}

function get_maturity_rating_id($name, &$database, $insert = FALSE) {
  try {
    $maturity_rating_type_id = get_type($name, MATURITY_RATING, $database);
  } catch (\Exception $e) {
    if ($e->getMessage() == RESULTS_ZERO && $insert == TRUE) {
      $maturity_rating_type_id = set_maturity_rating_id($name, $database);
    }
    else {
      throw new \Exception($e->getMessage() . "\n\n" . $database->last());
    }
  }

  return $maturity_rating_type_id;
}

function set_maturity_rating_id($name, &$database) {
  return set_type($name, MATURITY_RATING, $database);
}

function get_mechanics_id($name, &$database, $insert = FALSE) {
  try {
    $mechanics_id = get_type($name, MECHANICS, $database);
  } catch (\Exception $e) {
    if ($e->getMessage() == RESULTS_ZERO && $insert == TRUE) {
      $mechanics_id = set_mechanics_id($name, $database);
    }
    else {
      throw new \Exception($e->getMessage() . "\n\n" . $database->last());
    }
  }

  return $mechanics_id;
}

function set_mechanics_id($name, &$database) {
  return set_type($name, MECHANICS, $database);
}

function get_genre_id($name, &$database, $insert = FALSE) {
  try {
    $genre_id = get_type($name, GENRES, $database);
  } catch (\Exception $e) {
    if ($e->getMessage() == RESULTS_ZERO && $insert == TRUE) {
      $genre_id = set_genre_id($name, $database);
    }
    else {
      throw new \Exception($e->getMessage() . "\n\n" . $database->last());
    }
  }

  return $genre_id;
}

function set_genre_id($name, &$database) {
  return set_type($name, GENRES, $database);
}

function get_company_id($name, &$database, $insert = FALSE) {
  $company_id = $database->select('companies', ['id'], ['name [~]' => (string) trim($name)]);

  if (count($company_id) == 1) {
    $company_id = $company_id[0]['id'];
  }
  elseif (count($company_id) < 1 && $insert == TRUE) {
    $company_id = set_company_id($name, $database);
  }
  elseif (count($company_id) > 1) {
    throw new \Exception(RESULTS_MULTIPLE, 1);
  }

  return $company_id;
}

function set_company_id($name, &$database) {
  $database->insert('companies', [
    'name' => (string) trim($name),
  ]);
  return $database->id();
}

function get_console_id($name, &$database, $insert = FALSE) {
  $console_id = $database->select('consoles', ['id'], ['short_name [=]' => (string) trim($name)]);

  if (count($console_id) == 1) {
    $console_id = $console_id[0]['id'];
  }
  elseif (count($console_id) < 1 && $insert == TRUE) {
    $console_id = set_console_id($name, $database);
  }
  elseif (count($console_id) > 1) {
    throw new \Exception(RESULTS_MULTIPLE, 1);
  }

  return $console_id;
}

function set_console_id($name, &$database) {
  $database->insert('consoles', [
    'name' => (string) $name,
  ]);
  return $database->id();
}

function get_type($type_name, $category_name, &$database, $insert = FALSE, $allow_multiple = FALSE) {
  try {
    $category_id = get_category($category_name, $database);
  } catch (\Exception $e) {
    throw new \Exception(RESULTS_INVALID, 1);
  }
  $type = $database->select('types', ['id'], [
    'and' => [
      'category_id [=]' => $category_id,
      'name [~]'        => (string) trim($type_name)
    ]
  ]);

  $type_id = NULL;
  if (count($type) == 1) {
    $type_id = $type[0]['id'];
  }
  elseif (count($type) > 1 && !$allow_multiple) {
    throw new \Exception(RESULTS_MULTIPLE, 1);
  }
  elseif (count($type) < 1 && $insert == TRUE) {
    $type_id = set_type((string) $type_name, $category_name, $database);
  }
  elseif (count($type) < 1) {
    throw new \Exception(RESULTS_ZERO, 1);
  }
  else {
    throw new \Exception(RESULTS_INVALID, 1);
  }
  return $type_id;
}

function set_type($name, $category, &$database) {
  try {
    $category_id = get_category($category, $database);
  } catch (\Exception $e) {
    throw new \Exception($e->getMessage() . "\n\n" . $database->last());
  }

  $database->insert(TBL_TYPE, [
    'name'        => (string) trim($name),
    'category_id' => (int) $category_id,
  ]);

  return $database->id();
}

function get_category($category_name, &$database, $insert = FALSE) {
  $categories = $database->select('categories', ['id'], ['name [~]' => (string) trim($category_name),]);
  $category_id = null;

  if (count($categories) == 1) {
    $category_id = $categories[0]['id'];
  }
  elseif (count($categories) > 1) {
    throw new \Exception(RESULTS_MULTIPLE, 1);
  }
  elseif (count($categories) < 1 && $insert == TRUE) {
    $category_id = set_category($category_name, $database);
  }
  elseif (count($categories) < 1) {
    throw new \Exception(RESULTS_ZERO, 1);
  }
  else {
    throw new \Exception(RESULTS_INVALID, 1);
  }

  if ($category_id == null) {
    // This should never be called as all code paths throw an error or return an int.
    throw new \Exception('Something else went horribly wrong. Please resolve', 1);
  }

  return $category_id;
}

function set_category($category, &$database) {
  $database->insert(TBL_CATEGORY, [
    'name' => (string) trim($category),
  ]);

  return $database->id();
}

function truthy($input) {
  if ($input == 'Y') {
    return YES;
  }

  return NO;
}

function check_database_error(&$database) {
  $error_code    = intval($database->error()[1]);
  $error_message = $database->error()[2];

  if ($error_code == 1054) {
    $error_last_query = $database->last();
    throw new \Exception($error_message . "\n" . $error_last_query);
  }
  elseif ($error_code == 0) {
    return TRUE;
  }
  else {
    $error_last_query = $database->last();
    throw new \Exception('Some other error:' . $error_code . ' ' . $error_message . "\n" . $error_last_query);
  }
}
