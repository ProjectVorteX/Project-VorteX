-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.16 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             6.0.0.4018
-- Date/time:                    2012-03-09 12:59:57
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table world.locales_points_of_interest
DROP TABLE IF EXISTS `locales_points_of_interest`;
CREATE TABLE IF NOT EXISTS `locales_points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `icon_name_loc1` text,
  `icon_name_loc2` text,
  `icon_name_loc3` text,
  `icon_name_loc4` text,
  `icon_name_loc5` text,
  `icon_name_loc6` text,
  `icon_name_loc7` text,
  `icon_name_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='CTDB Points of interest locales';

-- Dumping data for table world.locales_points_of_interest: 0 rows
/*!40000 ALTER TABLE `locales_points_of_interest` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_points_of_interest` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
