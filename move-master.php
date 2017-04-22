<?php
/**
 * Created by PhpStorm.
 * User: nazario
 * Date: 3/4/17
 * Time: 9:52 PM
 */
require_once __DIR__ . '/sensitive-settings.php';
require_once __DIR__ . '/common.php';
require_once __DIR__ . '/Medoo/medoo.php';

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
}

echo 'Starting' . "\n\n";

$data = $database->select(TBL_MEDIA, [
  'foreign_id',
  'foreign_type',
  'file_name',
], [
  'file_name[!]' => '**DEAD**',
]);

check_database_error($database);



foreach ($data as $key => $item) {
    $full_source_path      = implode('/', [$media_path['source'], $item['file_name']]);
    $full_destination_path = implode('/', [$media_path['destination'], 'game',  $item['foreign_type'], $item['foreign_id'],]);

    if (file_exists($full_source_path)) {
        mkdir($full_destination_path);
        rename($full_source_path, $full_destination_path .  '/' . $item['file_name']);
    } else {
        echo $item['file_name'] . PHP_EOL;
    }
}
