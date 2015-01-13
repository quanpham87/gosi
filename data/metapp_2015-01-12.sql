# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.21)
# Database: metapp
# Generation Time: 2015-01-13 07:26:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table action_item_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `action_item_users`;

CREATE TABLE `action_item_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_item_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_action_item_user_id` (`user_id`),
  KEY `fk_action_item_action_item_id` (`action_item_id`),
  CONSTRAINT `fk_action_item_action_item_id` FOREIGN KEY (`action_item_id`) REFERENCES `meeting_action_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_action_item_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table agenda_item_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agenda_item_users`;

CREATE TABLE `agenda_item_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `agenda_item_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agenda_item_user_user_id` (`user_id`),
  KEY `fk_agenda_item_user_agenda_item_id` (`agenda_item_id`),
  CONSTRAINT `fk_agenda_item_user_agenda_item_id` FOREIGN KEY (`agenda_item_id`) REFERENCES `agenda_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_agenda_item_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table agenda_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `agenda_items`;

CREATE TABLE `agenda_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `agenda_id` int(10) unsigned DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agenda_item_agenda_id` (`agenda_id`),
  CONSTRAINT `fk_agenda_item_agenda_id` FOREIGN KEY (`agenda_id`) REFERENCES `meeting_agenda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table group_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_users`;

CREATE TABLE `group_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_group_users_group_id` (`group_id`),
  KEY `fk_group_users_user_id` (`user_id`),
  CONSTRAINT `fk_group_users_group_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_group_owner_id` (`owner_id`),
  CONSTRAINT `fk_group_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_action_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_action_items`;

CREATE TABLE `meeting_action_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(200) DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `is_complete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_agenda
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_agenda`;

CREATE TABLE `meeting_agenda` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(11) unsigned DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agenda_meeting_id` (`meeting_id`),
  CONSTRAINT `fk_agenda_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_decisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_decisions`;

CREATE TABLE `meeting_decisions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_decision_meeting_id` (`meeting_id`),
  CONSTRAINT `fk_decision_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_materials
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_materials`;

CREATE TABLE `meeting_materials` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gdrive_url` varchar(300) DEFAULT NULL,
  `dropbox_url` varchar(300) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `meeting_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_material_meeting_id` (`meeting_id`),
  KEY `fk_material_user_id` (`user_id`),
  CONSTRAINT `fk_material_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_material_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_notes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_notes`;

CREATE TABLE `meeting_notes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `content` int(10) unsigned DEFAULT NULL,
  `is_important` tinyint(1) unsigned DEFAULT NULL,
  `is_question` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notes_meeting_id` (`meeting_id`),
  KEY `fk_notes_user_id` (`user_id`),
  CONSTRAINT `fk_notes_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_notes_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meeting_purposes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_purposes`;

CREATE TABLE `meeting_purposes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `meeting_purposes` WRITE;
/*!40000 ALTER TABLE `meeting_purposes` DISABLE KEYS */;

INSERT INTO `meeting_purposes` (`id`, `type`)
VALUES
	(1,'Solve problem'),
	(2,'Answer questions'),
	(3,'Brainstorming'),
	(4,'Other');

/*!40000 ALTER TABLE `meeting_purposes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table meeting_user_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_user_types`;

CREATE TABLE `meeting_user_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `meeting_user_types` WRITE;
/*!40000 ALTER TABLE `meeting_user_types` DISABLE KEYS */;

INSERT INTO `meeting_user_types` (`id`, `type`)
VALUES
	(1,'Organizer'),
	(2,'Attendee'),
	(3,'Watcher');

/*!40000 ALTER TABLE `meeting_user_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table meeting_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meeting_users`;

CREATE TABLE `meeting_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned DEFAULT NULL,
  `user_type_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meeting_users_meeting_id` (`meeting_id`),
  KEY `fk_meeting_users_user_type_id` (`user_type_id`),
  KEY `fk_meeting_users_user_id` (`user_id`),
  CONSTRAINT `fk_meeting_users_meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_meeting_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_meeting_users_user_type_id` FOREIGN KEY (`user_type_id`) REFERENCES `meeting_user_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table meetings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meetings`;

CREATE TABLE `meetings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `purpose_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meeting_purpose_id` (`purpose_id`),
  CONSTRAINT `fk_meeting_purpose_id` FOREIGN KEY (`purpose_id`) REFERENCES `meeting_purposes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `username` varchar(100) DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(200) NOT NULL DEFAULT '',
  `date_joined` datetime DEFAULT NULL,
  `date_last_logged_in` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
