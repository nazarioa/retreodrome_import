-- MySQL dump 10.16  Distrib 10.2.6-MariaDB, for osx10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: cake_retrodrome
-- ------------------------------------------------------
-- Server version	10.2.6-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cartridges`
--

DROP TABLE IF EXISTS `cartridges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cartridges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `region_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `game_default` tinyint(1) DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `special` tinyint(1) DEFAULT NULL,
  `prototype` tinyint(1) DEFAULT NULL,
  `demo` tinyint(1) DEFAULT NULL,
  `license` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cartridges_fk_game_id` (`game_id`),
  CONSTRAINT `cartridges_fk_game_id` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `fk_game_id` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartridges`
--

LOCK TABLES `cartridges` WRITE;
/*!40000 ALTER TABLE `cartridges` DISABLE KEYS */;
INSERT INTO `cartridges` VALUES (1,1,1,'**DEAD**','**DEAD**',1,1,1,1,1,1);
/*!40000 ALTER TABLE `cartridges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartridges_companies`
--

DROP TABLE IF EXISTS `cartridges_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cartridges_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cartridge_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `company_role_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cartridges_companies_fk_cartridge_id` (`cartridge_id`),
  KEY `cartridges_companies_fk_company_id` (`company_id`),
  KEY `cartridges_companies_fk_company_role_type_id` (`company_role_type_id`),
  CONSTRAINT `cartridges_companies_fk_cartridge_id` FOREIGN KEY (`cartridge_id`) REFERENCES `cartridges` (`id`),
  CONSTRAINT `cartridges_companies_fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `cartridges_companies_fk_company_role_type_id` FOREIGN KEY (`company_role_type_id`) REFERENCES `types` (`id`),
  CONSTRAINT `fk_cartridge_id` FOREIGN KEY (`cartridge_id`) REFERENCES `cartridges` (`id`),
  CONSTRAINT `fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `fk_company_role_type_id` FOREIGN KEY (`company_role_type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartridges_companies`
--

LOCK TABLES `cartridges_companies` WRITE;
/*!40000 ALTER TABLE `cartridges_companies` DISABLE KEYS */;
INSERT INTO `cartridges_companies` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `cartridges_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartridges_consoles`
--

DROP TABLE IF EXISTS `cartridges_consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cartridges_consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `console_id` int(11) DEFAULT NULL,
  `cartridge_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cartridges_consoles_fk_console_id` (`console_id`),
  CONSTRAINT `cartridges_consoles_fk_console_id` FOREIGN KEY (`console_id`) REFERENCES `consoles` (`id`),
  CONSTRAINT `fk_console_id` FOREIGN KEY (`console_id`) REFERENCES `consoles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartridges_consoles`
--

LOCK TABLES `cartridges_consoles` WRITE;
/*!40000 ALTER TABLE `cartridges_consoles` DISABLE KEYS */;
INSERT INTO `cartridges_consoles` VALUES (1,1,1);
/*!40000 ALTER TABLE `cartridges_consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'**DEAD**',''),(2,'Mechanic','Game play type First person shooter vs rails'),(3,'Genre','Sports vs Science Fiction'),(4,'Maturity Rating','HSRS or ESRB Rating'),(5,'Creation Role','Role of a company in the creation of a release'),(6,'Region',NULL),(7,'Other',NULL),(8,'Country Code',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_dir` varchar(255) DEFAULT NULL,
  `business_start_date` date DEFAULT NULL,
  `business_end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'**DEAD**',NULL,NULL,NULL,NULL,NULL),(2,'ASCII Entertainment',NULL,NULL,NULL,NULL,NULL),(3,'Acclaim',NULL,NULL,NULL,NULL,NULL),(4,'Activision',NULL,NULL,NULL,NULL,NULL),(5,'Atlus Co.',NULL,NULL,NULL,NULL,NULL),(6,'Bam Entertainment',NULL,NULL,NULL,NULL,NULL),(7,'BigBen Interactive',NULL,NULL,NULL,NULL,NULL),(8,'Capcom',NULL,NULL,NULL,NULL,NULL),(9,'Crave',NULL,NULL,NULL,NULL,NULL),(10,'EA Sports',NULL,NULL,NULL,NULL,NULL),(11,'Electro Brain',NULL,NULL,NULL,NULL,NULL),(12,'Electronic Arts',NULL,NULL,NULL,NULL,NULL),(13,'Fox Interactive',NULL,NULL,NULL,NULL,NULL),(14,'GMI',NULL,NULL,NULL,NULL,NULL),(15,'GT Interactive',NULL,NULL,NULL,NULL,NULL),(16,'GameTek',NULL,NULL,NULL,NULL,NULL),(17,'Gremlin Interactive',NULL,NULL,NULL,NULL,NULL),(18,'Hasbro Interactive',NULL,NULL,NULL,NULL,NULL),(19,'Infogrames',NULL,NULL,NULL,NULL,NULL),(20,'Interplay',NULL,NULL,NULL,NULL,NULL),(21,'Kemco',NULL,NULL,NULL,NULL,NULL),(22,'Koei',NULL,NULL,NULL,NULL,NULL),(23,'Konami',NULL,NULL,NULL,NULL,NULL),(24,'Lego Media',NULL,NULL,NULL,NULL,NULL),(25,'LucasArts',NULL,NULL,NULL,NULL,NULL),(26,'Midway',NULL,NULL,NULL,NULL,NULL),(27,'Mindscape Inc.',NULL,NULL,NULL,NULL,NULL),(28,'Namco',NULL,NULL,NULL,NULL,NULL),(29,'Natsume',NULL,NULL,NULL,NULL,NULL),(30,'NewKidCo',NULL,NULL,NULL,NULL,NULL),(31,'Nintendo',NULL,NULL,NULL,NULL,NULL),(32,'Ocean',NULL,NULL,NULL,NULL,NULL),(33,'Rare Ltd.',NULL,NULL,NULL,NULL,NULL),(34,'Red Storm Entertainment',NULL,NULL,NULL,NULL,NULL),(35,'Rockstar Games',NULL,NULL,NULL,NULL,NULL),(36,'SouthPeak Games',NULL,NULL,NULL,NULL,NULL),(37,'SunSoft',NULL,NULL,NULL,NULL,NULL),(38,'THQ',NULL,NULL,NULL,NULL,NULL),(39,'Take-Two Interactive',NULL,NULL,NULL,NULL,NULL),(40,'Titus Software',NULL,NULL,NULL,NULL,NULL),(41,'UFO Interactive',NULL,NULL,NULL,NULL,NULL),(42,'Ubisoft',NULL,NULL,NULL,NULL,NULL),(43,'Vatical Entertainment',NULL,NULL,NULL,NULL,NULL),(44,'Vic Tokai',NULL,NULL,NULL,NULL,NULL),(45,'Video System',NULL,NULL,NULL,NULL,NULL),(46,'3DO',NULL,NULL,NULL,NULL,NULL),(182,'Taito Corporation',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies_consoles`
--

DROP TABLE IF EXISTS `companies_consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `console_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `company_role_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_consoles_fk_console_id` (`console_id`),
  KEY `companies_consoles_fk_company_id` (`company_id`),
  KEY `companies_consoles_fk_company_role_type_id` (`company_role_type_id`),
  CONSTRAINT `companies_consoles_fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `companies_consoles_fk_company_role_type_id` FOREIGN KEY (`company_role_type_id`) REFERENCES `types` (`id`),
  CONSTRAINT `companies_consoles_fk_console_id` FOREIGN KEY (`console_id`) REFERENCES `consoles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies_consoles`
--

LOCK TABLES `companies_consoles` WRITE;
/*!40000 ALTER TABLE `companies_consoles` DISABLE KEYS */;
INSERT INTO `companies_consoles` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `companies_consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies_people`
--

DROP TABLE IF EXISTS `companies_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_people_fk_company_id` (`company_id`),
  KEY `companies_people_fk_person_id` (`person_id`),
  CONSTRAINT `companies_people_fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `companies_people_fk_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies_people`
--

LOCK TABLES `companies_people` WRITE;
/*!40000 ALTER TABLE `companies_people` DISABLE KEYS */;
INSERT INTO `companies_people` VALUES (1,1,1,'1990-01-01','1990-01-01');
/*!40000 ALTER TABLE `companies_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies_releases`
--

DROP TABLE IF EXISTS `companies_releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_releases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `release_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `company_role_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_releases_fk_company_id` (`company_id`),
  KEY `companies_releases_fk_company_role_type_id` (`company_role_type_id`),
  CONSTRAINT `companies_releases_fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `companies_releases_fk_company_role_type_id` FOREIGN KEY (`company_role_type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies_releases`
--

LOCK TABLES `companies_releases` WRITE;
/*!40000 ALTER TABLE `companies_releases` DISABLE KEYS */;
INSERT INTO `companies_releases` VALUES (1,1,1,1);
/*!40000 ALTER TABLE `companies_releases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consoles`
--

DROP TABLE IF EXISTS `consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_dir` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `life_start_date` date DEFAULT NULL,
  `life_end_date` date DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consoles`
--

LOCK TABLES `consoles` WRITE;
/*!40000 ALTER TABLE `consoles` DISABLE KEYS */;
INSERT INTO `consoles` VALUES (1,'**DEAD**',NULL,NULL,'**DEAD**',NULL,NULL,'**DEAD**',1),(2,'Gameboy',NULL,NULL,NULL,'1989-04-21',NULL,'GB',0),(3,'Gameboy Advanced',NULL,NULL,NULL,'2001-03-21',NULL,'GBA',0),(4,'Gameboy Color',NULL,NULL,NULL,'1998-10-21',NULL,'GBC',0),(5,'Nintendo 64',NULL,NULL,NULL,'1996-06-23',NULL,'N64',0),(6,'Nintendo Entertainment System',NULL,NULL,NULL,'1983-07-15',NULL,'NES',0),(7,'Super Nintendo Entertainment System',NULL,NULL,NULL,'1990-11-21',NULL,'SNES',0),(8,'Virtual Boy',NULL,NULL,NULL,'1995-07-21',NULL,'VB',0);
/*!40000 ALTER TABLE `consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `series_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `mechanics_category_id` int(11) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `series_id` (`series_id`),
  CONSTRAINT `fk_series_id` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`),
  CONSTRAINT `games_fk_series_id` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`),
  CONSTRAINT `games_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,1,'**DEAD**',1,1);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games_genres`
--

DROP TABLE IF EXISTS `games_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_type_id` int(11) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `games_genres_fk_genre_type_id` (`genre_type_id`),
  KEY `games_genres_fk_game_id` (`game_id`),
  CONSTRAINT `fk_genre_type_id` FOREIGN KEY (`genre_type_id`) REFERENCES `types` (`id`),
  CONSTRAINT `games_genres_fk_game_id` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `games_genres_fk_genre_type_id` FOREIGN KEY (`genre_type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games_genres`
--

LOCK TABLES `games_genres` WRITE;
/*!40000 ALTER TABLE `games_genres` DISABLE KEYS */;
INSERT INTO `games_genres` VALUES (1,1,1);
/*!40000 ALTER TABLE `games_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games_related`
--

DROP TABLE IF EXISTS `games_related`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games_related` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `related_game_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `games_related_fk_game_id` (`game_id`),
  KEY `games_related_fk_related_game_id` (`related_game_id`),
  CONSTRAINT `fk_related_game_id` FOREIGN KEY (`related_game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `games_related_fk_game_id` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `games_related_fk_related_game_id` FOREIGN KEY (`related_game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games_related`
--

LOCK TABLES `games_related` WRITE;
/*!40000 ALTER TABLE `games_related` DISABLE KEYS */;
/*!40000 ALTER TABLE `games_related` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `greets`
--

DROP TABLE IF EXISTS `greets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `background_path` varchar(255) DEFAULT NULL,
  `sprite_path` varchar(255) DEFAULT NULL,
  `quote` varchar(255) DEFAULT NULL,
  `cite` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `greets`
--

LOCK TABLES `greets` WRITE;
/*!40000 ALTER TABLE `greets` DISABLE KEYS */;
INSERT INTO `greets` VALUES (1,'castlevania-bk.gif','',' Die, monster! You don\'t belong in this world!','Richter Belmont'),(2,'contra-bk.gif','contra-sprite.gif','It\'s time for revenge. Let\'s attack aggressively!','Xiaomu'),(3,'kirbysadventure-bk.gif','kirbysadventure-sprite.gif','Bubble, Bubble, yahoo!','Kirrby'),(4,'megaman-bk.gif','megaman-sprite.gif','Boom boom boom!','Megaman'),(5,'legendofzelda-bk.gif','legendofzelda-sprite.gif','You\'ve got to be kidding!','Zelda'),(6,'miketysonspunchout-bk.gif','miketysonspunchout-sprite.gif','I taw I taw a puddy tat','Tyson'),(7,'ninjagaidenii-bk.gif','ninjagaidenii-sprite.gif',NULL,NULL),(8,'supermariobros3-bk.gif','supermariobros3-sprite.gif','Hello, it\'s me! Mario!','Mario'),(9,'teenagemutantninjaturtlesiithearcadegame-bk.gif','teenagemutantninjaturtlesiithearcadegame-sprite.gif','Cowabunga','Rafael');
/*!40000 ALTER TABLE `greets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foreign_id` int(11) DEFAULT NULL,
  `foreign_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `mime_type` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file_name` (`file_name`),
  KEY `entry_index` (`foreign_id`,`foreign_type`,`role`) USING BTREE,
  KEY `media_index` (`foreign_id`,`foreign_type`,`role`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,'releases','**DEAD**',NULL,NULL,NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'**DEAD**','**DEAD**','**DEAD**','**DEAD**');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `releases`
--

DROP TABLE IF EXISTS `releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `releases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cartridge_id` int(11) unsigned NOT NULL,
  `country_type_id` int(11) unsigned NOT NULL,
  `maturity_rating_type_id` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_official_release` int(1) DEFAULT NULL,
  `quantities_shipped` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `releases_fk_maturity_rating_type_id` (`maturity_rating_type_id`),
  KEY `releases_index` (`cartridge_id`,`country_type_id`) USING BTREE,
  CONSTRAINT `releases_fk_maturity_rating_type_id` FOREIGN KEY (`maturity_rating_type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `releases`
--

LOCK TABLES `releases` WRITE;
/*!40000 ALTER TABLE `releases` DISABLE KEYS */;
INSERT INTO `releases` VALUES (1,1,1,1,'1990-01-01',1,1);
/*!40000 ALTER TABLE `releases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series`
--

LOCK TABLES `series` WRITE;
/*!40000 ALTER TABLE `series` DISABLE KEYS */;
INSERT INTO `series` VALUES (1,'**DEAD**','**DEAD**');
/*!40000 ALTER TABLE `series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `test_start_date` date DEFAULT NULL,
  `test_end_date` date DEFAULT NULL,
  `enabled` enum('y','n') DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `order` int(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `types_fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `types_fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,1,'**DEAD**',NULL,NULL),(2,2,'Rail',NULL,NULL),(3,2,'Side scroller',NULL,NULL),(4,2,'Platform',NULL,NULL),(5,2,'Puzzle',NULL,NULL),(6,2,'Turn Based',NULL,NULL),(7,2,'First Person',NULL,NULL),(8,2,'Light Gun',NULL,NULL),(9,3,'Sports',NULL,NULL),(11,3,'Action',NULL,NULL),(12,3,'Adventure',NULL,NULL),(15,3,'Beat-\'Em-Up',NULL,NULL),(17,3,'Board Games',NULL,NULL),(21,3,'Casino',NULL,NULL),(22,3,'Compilation',NULL,NULL),(25,3,'Educational',NULL,NULL),(26,3,'Fighting',NULL,NULL),(30,3,'Game Show',NULL,NULL),(32,3,'Light Gun',NULL,NULL),(34,3,'Maze',NULL,NULL),(35,3,'Party',NULL,NULL),(36,3,'Miscellaneous',NULL,NULL),(39,3,'Pinball',NULL,NULL),(40,3,'Platform',NULL,NULL),(42,3,'Puzzle',NULL,NULL),(43,3,'Rhythm',NULL,NULL),(44,3,'Role-Playing',NULL,NULL),(45,3,'Shoot-\'Em-Up',NULL,NULL),(46,3,'Shooter',NULL,NULL),(47,3,'Simulation',NULL,NULL),(53,3,'Strategy',NULL,NULL),(59,4,'E',NULL,'Everyone'),(60,4,'T',NULL,'Teen'),(61,4,'M',NULL,'Mature'),(62,4,'EC',NULL,'Early Childhood'),(63,4,'E10+',NULL,'Everyone 10+'),(64,4,'AO',NULL,'Adults Only'),(65,5,'Publisher',NULL,NULL),(66,5,'Developer',NULL,NULL),(67,4,'GA',NULL,NULL),(68,2,'Flying',NULL,NULL),(69,2,'Fighting',NULL,NULL),(70,2,'Racing',NULL,NULL),(71,2,'Shooting',NULL,NULL),(72,2,'Driving',NULL,NULL),(73,3,'Racing',NULL,NULL),(74,6,'NTSC',NULL,NULL),(75,6,'PAL',NULL,NULL),(76,2,'Other',NULL,NULL),(77,4,'RP',NULL,'Rate Pending'),(78,8,'USA',NULL,NULL),(79,8,'MEX',NULL,NULL),(80,6,'ALL',NULL,'All regions commonly used for handheld games.'),(81,4,'3',NULL,'Pegi Rating 3'),(82,4,'7',NULL,'Pegi Rating 7'),(83,4,'12',NULL,'Pegi Rating 12'),(84,4,'16',NULL,'Pegi Rating 16'),(85,4,'18',NULL,'Pegi Rating 18'),(86,4,'NR',NULL,'Not Rated'),(87,8,'ALL',NULL,NULL),(88,3,'Flying',NULL,'Flight simulators'),(89,3,'Mini-Games',NULL,NULL);
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-30 18:16:54
