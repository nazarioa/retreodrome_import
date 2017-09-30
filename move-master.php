<?php
/**
 * Created by PhpStorm.
 * User: nazario
 * Date: 3/4/17
 * Time: 9:52 PM
 *
 * This script is used to move image artwork from an unorganized file system
 * to its correct spot in webserver. The correct spot correlates with and entry
 * in the database.
 * This script assumes that the entry in the database already exists and wont
 * create new entries in the database.
 */
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

/*
 * This is a pref-light check.
 * Tests the database connection.
 */
try {
    $database = new medoo($settings);
} catch (Exception $e) {
    $message = 'I cannot connect to the database!' . "\n" . '- Is MySQL running?' . "\n" . '- Do you have the right username and password?' . "\n" . '- Does a database named "' . $settings['database_name'] . '"  exist?' . "\n\n" . 'Connection settings are:' . "\n\n";
    $message .= print_r($settings, true);

    die($message);
}

if (IMPORT_MEDIA == true) {
    if (
    !isset($media_path['destination'])
    || !is_writable($media_path['destination'])
  ) {
        throw new Exception('Array `media_path["destination"]` is not found or writable: ' . $media_path['destination']);
    }

    if (
  !isset($media_path['source'])
  ) {
        throw new Exception('Array `media_path["source"]` is not found or writable: ' . $media_path['source']);
    }
/*
 * This is a pref-light check.
 * If the IMPORT_MEDIA flag is on, lets make sure we have the correct environment variables.
 *
 * @param $media_path['destination'] : Root directory of cakePHPs file storage
 * defined as webroot/files/
 *
 * @param $media_path['source'] : Place where the raw media is coming from.
 */
}

echo 'Starting' . "\n\n";

$data = $database->select(TBL_MEDIA, [
/*
 * Gets all the artwork information that currently lives in the database.
 */
  'foreign_id',
  'foreign_type',
  'file_name',
], [
  'file_name[!]' => '**DEAD**',
]);

check_database_error($database);

/*
 * For each entry in the media table:
 */


foreach ($data as $key => $item) {
    $full_source_path      = implode('/', [$media_path['source'], $item['file_name']]);
    $full_destination_path = implode('/', [$media_path['destination'], 'game',  $item['foreign_type'], $item['foreign_id'],]);

    if (file_exists($full_source_path)) {
        mkdir($full_destination_path);
        rename($full_source_path, $full_destination_path .  '/' . $item['file_name']);
    } else {
        echo $item['file_name'] . PHP_EOL;
    }
  /*
   * If the file exists, move the file to its new home.
   */
}
