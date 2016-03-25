<?php
define ('RESULTS_MULTIPLE', 'Found >1 categories');
define ('RESULTS_ZERO', 'Found 0 categories');
define ('RESULTS_INVALID', 'Invalid Results');

define ('MECHANICS', 'Mechanics');
define ('GENRES', 'Genres');
define ('MATURITY_RATING', 'Maturity Rating');
define ('CREATION_ROLE', 'Creation Role');
define ('REGIONS', 'Regions');
define ('OTHER', 'Other');
define ('COUNTRIES', 'Countries');

define ('YES', 1);
define ('NO', 0);



// Helper functions

function get_region_id ( (string) $name, &$database, $insert = false) {
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


function get_maturity_rating_id ( (string) $name, &$database, $insert = false) {
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

function set_maturity_rating_id ( (string) $name, &$database) {
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

function set_mechanics_id ( (string) $name, &$database) {
  return set_type ($name, MECHANICS, $database);
}


function get_genre_id ( (string) $name, &$database, $insert = false) {
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

function set_genre_id ( (string) $name, &$database) {
  return set_type ($name, GENRES, $database);
}


function get_company_id ( (string) $name, &$database, $insert = false) {
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

function set_company_id ( (string) $name, &$database) {
  $company_id = $database->insert ('companies', [
    'name' => (string) $name,
  ]);
  return $company_id;
}


function get_console_id ( (string) $name, &$database, $insert = false) {
  $console_id = $database->select ('consoles', ['id'], ['name [=]' => (string) $name]);

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

function set_console_id ( (string) $name, &$database) {
  $company_id = $database->insert ('consoles', [
    'name' => (string) $name,
  ]);
  return $company_id;
}


function get_type ( (string) $type_name, $category_name, &$database, $insert = false) {
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

function set_type ( (string) $name, $category, &$database) {
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

function get_category ( (string) $category_name, &$database) {
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
