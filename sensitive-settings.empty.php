<?php
namespace Retrodrome\Import;

// Make a copy of this file and rename it to:
// sensitive-settings.php
$settings = array(
  'database_type' => 'mysql',
  'database_name' => 'name_here',
  'server' => 'server_address_here',
  'username' => 'user_name_here',
  'password' => 'password_here',
  'charset' => 'utf8'
);

// Should images be imported.
define('IMPORT_MEDIA', TRUE);

// Media source and destination paths.
$media_path['source'] = '/full/path/to/retrodrome_import/data/RetrodormeMedia';
$media_path['destination'] = '/full/path/to/retrodrome/webroot/files';

// Systems to import. Pick and choose:
// 'GB', 'GBA', 'GBC', 'SNES', 'NES', 'N64', 'VB'
$systems_to_import = array();
