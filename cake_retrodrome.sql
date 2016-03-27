/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : 127.0.0.1
 Source Database       : cake_retrodrome

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : utf-8

 Date: 03/27/2016 01:58:02 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `cartridges`
-- ----------------------------
DROP TABLE IF EXISTS `cartridges`;
CREATE TABLE `cartridges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `region_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `game_default` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `special` tinyint(1) DEFAULT NULL,
  `prototype` tinyint(1) DEFAULT NULL,
  `demo` tinyint(1) DEFAULT NULL,
  `license` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `game_default` (`id`,`game_default`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `cartridges_companies`
-- ----------------------------
DROP TABLE IF EXISTS `cartridges_companies`;
CREATE TABLE `cartridges_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cartridge_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `company_role_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`cartridge_id`,`company_id`,`company_role_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `cartridges_consoles`
-- ----------------------------
DROP TABLE IF EXISTS `cartridges_consoles`;
CREATE TABLE `cartridges_consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `console_id` int(11) DEFAULT NULL,
  `cartridge_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `categories`
-- ----------------------------
BEGIN;
INSERT INTO `categories` VALUES ('1', '**DEAD**', ''), ('2', 'Mechanic', 'Game play type First person shooter vs rails'), ('3', 'Genre', 'Sports vs Science Fiction'), ('4', 'Maturity Rating', 'HSRS or ESRB Rating'), ('5', 'Creation Role', 'Role of a company in the creation of a release'), ('6', 'Region', null), ('7', 'Other', null), ('8', 'Country Code', null);
COMMIT;

-- ----------------------------
--  Table structure for `companies`
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `logo` varchar(255) DEFAULT NULL,
  `logo_dir` varchar(255) DEFAULT NULL,
  `business_start_date` date DEFAULT NULL,
  `business_end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `companies_consoles`
-- ----------------------------
DROP TABLE IF EXISTS `companies_consoles`;
CREATE TABLE `companies_consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `console_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `company_role_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `companies_people`
-- ----------------------------
DROP TABLE IF EXISTS `companies_people`;
CREATE TABLE `companies_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `consoles`
-- ----------------------------
DROP TABLE IF EXISTS `consoles`;
CREATE TABLE `consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_dir` varchar(255) DEFAULT NULL,
  `description` text,
  `life_start_date` date DEFAULT NULL,
  `life_end_date` date DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `games`
-- ----------------------------
DROP TABLE IF EXISTS `games`;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `series_id` int(11) DEFAULT NULL,
  `description` text,
  `mechanics_category_id` int(11) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `games_genres`
-- ----------------------------
DROP TABLE IF EXISTS `games_genres`;
CREATE TABLE `games_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_type_id` int(11) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`genre_type_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `games_related`
-- ----------------------------
DROP TABLE IF EXISTS `games_related`;
CREATE TABLE `games_related` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `related_game_id` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `media`
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foreign_id` int(11) DEFAULT NULL,
  `foreign_type` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `mime_type` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `people`
-- ----------------------------
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `bio` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `releases`
-- ----------------------------
DROP TABLE IF EXISTS `releases`;
CREATE TABLE `releases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cartridge_id` int(11) unsigned NOT NULL,
  `country_type_id` int(11) unsigned NOT NULL,
  `maturity_rating_type_id` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_official_release` int(1) DEFAULT NULL,
  `quantities_shipped` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `series`
-- ----------------------------
DROP TABLE IF EXISTS `series`;
CREATE TABLE `series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `tests`
-- ----------------------------
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `test_start_date` date DEFAULT NULL,
  `test_end_date` date DEFAULT NULL,
  `enabled` enum('y','n') DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `types`
-- ----------------------------
DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `types`
-- ----------------------------
BEGIN;
INSERT INTO `types` VALUES ('1', '1', '**DEAD**', null), ('2', '2', 'Rail', null), ('3', '2', 'Side scroller', null), ('4', '2', 'Platform', null), ('5', '2', 'Puzzle', null), ('6', '2', 'Turn Based', null), ('7', '2', 'First Person', null), ('8', '2', 'Light Gun', null), ('9', '3', 'Sports', null), ('11', '3', 'Action', null), ('12', '3', 'Adventure', null), ('15', '3', 'Beat-\'Em-Up', null), ('17', '3', 'Board Games', null), ('21', '3', 'Casino', null), ('22', '3', 'Compilation', null), ('25', '3', 'Educational', null), ('26', '3', 'Fighting', null), ('30', '3', 'Game Show', null), ('32', '3', 'Light Gun', null), ('34', '3', 'Maze', null), ('35', '3', 'Party', null), ('36', '3', 'Miscellaneous', null), ('39', '3', 'Pinball', null), ('40', '3', 'Platform', null), ('42', '3', 'Puzzle', null), ('43', '3', 'Rhythm', null), ('44', '3', 'Role-Playing', null), ('45', '3', 'Shoot-\'Em-Up', null), ('46', '3', 'Shooter', null), ('47', '3', 'Simulation', null), ('53', '3', 'Strategy', null), ('59', '4', 'E', 'Everyone'), ('60', '4', 'T', 'Teen'), ('61', '4', 'M', 'Mature'), ('62', '4', 'EC', 'Early Childhood'), ('63', '4', 'E 10+', 'Everyone 10+'), ('64', '4', 'AO', 'Adults Only'), ('65', '5', 'Publisher', null), ('66', '5', 'Developer', null), ('67', '4', 'GA', null), ('68', '2', 'Flying', null), ('69', '2', 'Fighting', null), ('70', '2', 'Racing', null), ('71', '2', 'Shooting', null), ('72', '2', 'Driving', null), ('73', '3', 'Racing', null), ('74', '6', 'NTSC', null), ('75', '6', 'PAL', null), ('76', '2', 'Other', null), ('77', '4', 'RP', 'Rate Pending'), ('78', '8', 'USA', null), ('79', '8', 'MEX', null), ('80', '6', 'All', 'All regions commonly used for handheld games.');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
