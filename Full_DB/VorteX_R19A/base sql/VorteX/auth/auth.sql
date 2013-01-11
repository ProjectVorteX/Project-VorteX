/*
http://www.vortex-db.com
Auth database
Update: 22/04/2012
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`auth` /*!40100 DEFAULT CHARACTER SET latin1 */;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` VARCHAR(32) NOT NULL DEFAULT '',
  `sha_pass_hash` VARCHAR(40) NOT NULL DEFAULT '',
  `sessionkey` LONGTEXT,
  `v` LONGTEXT,
  `s` LONGTEXT,
  `email` TEXT,
  `joindate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` VARCHAR(30) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `locked` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `last_login` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` TINYINT(4) NOT NULL DEFAULT '0',
  `expansion` TINYINT(3) UNSIGNED NOT NULL DEFAULT '3',
  `mutetime` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0',
  `locale` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `recruiter` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=INNODB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Account System';

/*Data for the table `account` */

/*Table structure for table `account_access` */

DROP TABLE IF EXISTS `account_access`;

CREATE TABLE `account_access` (
  `id` INT(11) UNSIGNED NOT NULL,
  `gmlevel` TINYINT(3) UNSIGNED NOT NULL,
  `RealmID` INT(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `account_access` */

/*Table structure for table `account_banned` */

DROP TABLE IF EXISTS `account_banned`;

CREATE TABLE `account_banned` (
  `id` INT(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` BIGINT(40) NOT NULL DEFAULT '0',
  `unbandate` BIGINT(40) NOT NULL DEFAULT '0',
  `bannedby` VARCHAR(50) NOT NULL,
  `banreason` VARCHAR(255) NOT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ban List';

/*Data for the table `account_banned` */

/*Table structure for table `account_premium` */

DROP TABLE IF EXISTS `account_premium`;

CREATE TABLE `account_premium` (
  `id` INT(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `setdate` BIGINT(40) NOT NULL DEFAULT '0',
  `unsetdate` BIGINT(40) NOT NULL DEFAULT '0',
  `premium_type` TINYINT(4) UNSIGNED NOT NULL DEFAULT '1',
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`setdate`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Premium Accounts';

/*Data for the table `account_premium` */

/*Table structure for table `ip_banned` */

DROP TABLE IF EXISTS `ip_banned`;

CREATE TABLE `ip_banned` (
  `ip` VARCHAR(32) NOT NULL DEFAULT '127.0.0.1',
  `bandate` BIGINT(40) NOT NULL,
  `unbandate` BIGINT(40) NOT NULL,
  `bannedby` VARCHAR(50) NOT NULL DEFAULT '[Console]',
  `banreason` VARCHAR(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Banned IPs';

/*Data for the table `ip_banned` */

/*Table structure for table `logs` */

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `time` INT(14) NOT NULL,
  `realm` INT(4) NOT NULL,
  `type` INT(4) NOT NULL,
  `string` TEXT
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

/*Data for the table `logs` */

/*Table structure for table `realmcharacters` */

DROP TABLE IF EXISTS `realmcharacters`;

CREATE TABLE `realmcharacters` (
  `realmid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `acctid` BIGINT(20) UNSIGNED NOT NULL,
  `numchars` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm Character Tracker';

/*Data for the table `realmcharacters` */

/*Table structure for table `realmlist` */

DROP TABLE IF EXISTS `realmlist`;

CREATE TABLE `realmlist` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL DEFAULT '',
  `address` VARCHAR(32) NOT NULL DEFAULT '127.0.0.1',
  `port` INT(11) NOT NULL DEFAULT '8085',
  `icon` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `color` TINYINT(3) UNSIGNED NOT NULL DEFAULT '2',
  `timezone` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `allowedSecurityLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `population` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `online` INT(11) NOT NULL DEFAULT '0',
  `gamebuild` INT(11) UNSIGNED NOT NULL DEFAULT '13623',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=MYISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm System';

/*Data for the table `realmlist` */

/*Table structure for table `uptime` */

DROP TABLE IF EXISTS `uptime`;

CREATE TABLE `uptime` (
  `realmid` INT(11) UNSIGNED NOT NULL,
  `starttime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `startstring` VARCHAR(64) NOT NULL DEFAULT '',
  `uptime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `maxplayers` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `revision` VARCHAR(255) NOT NULL DEFAULT 'Trinitycore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';

/*Data for the table `uptime` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;