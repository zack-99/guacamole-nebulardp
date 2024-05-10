-- MySQL dump 10.13  Distrib 8.3.0, for Linux (x86_64)
--
-- Host: localhost    Database: guacamole_db
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `guacamole_connection`
--

DROP TABLE IF EXISTS `guacamole_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection` (
  `connection_id` int NOT NULL AUTO_INCREMENT,
  `connection_name` varchar(128) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `protocol` varchar(32) NOT NULL,
  `proxy_port` int DEFAULT NULL,
  `proxy_hostname` varchar(512) DEFAULT NULL,
  `proxy_encryption_method` enum('NONE','SSL') DEFAULT NULL,
  `max_connections` int DEFAULT NULL,
  `max_connections_per_user` int DEFAULT NULL,
  `connection_weight` int DEFAULT NULL,
  `failover_only` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`connection_id`),
  UNIQUE KEY `connection_name_parent` (`connection_name`,`parent_id`),
  KEY `guacamole_connection_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection`
--

LOCK TABLES `guacamole_connection` WRITE;
/*!40000 ALTER TABLE `guacamole_connection` DISABLE KEYS */;
INSERT INTO `guacamole_connection` VALUES (1,'some-host',NULL,'rdp',NULL,NULL,NULL,NULL,NULL,NULL,0),(2,'some-ssh',NULL,'ssh',NULL,NULL,NULL,NULL,NULL,NULL,0),(3,'rdesktop',NULL,'nebulardp',NULL,NULL,NULL,NULL,NULL,NULL,0),(4,'ball',NULL,'ball',NULL,NULL,'NONE',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `guacamole_connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_attribute` (
  `connection_id` int NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`attribute_name`),
  KEY `connection_id` (`connection_id`),
  CONSTRAINT `guacamole_connection_attribute_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_attribute`
--

LOCK TABLES `guacamole_connection_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group`
--

DROP TABLE IF EXISTS `guacamole_connection_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group` (
  `connection_group_id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `connection_group_name` varchar(128) NOT NULL,
  `type` enum('ORGANIZATIONAL','BALANCING') NOT NULL DEFAULT 'ORGANIZATIONAL',
  `max_connections` int DEFAULT NULL,
  `max_connections_per_user` int DEFAULT NULL,
  `enable_session_affinity` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`connection_group_id`),
  UNIQUE KEY `connection_group_name_parent` (`connection_group_name`,`parent_id`),
  KEY `guacamole_connection_group_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_group_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group`
--

LOCK TABLES `guacamole_connection_group` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group_attribute` (
  `connection_group_id` int NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_group_id`,`attribute_name`),
  KEY `connection_group_id` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_attribute_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_attribute`
--

LOCK TABLES `guacamole_connection_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group_permission` (
  `entity_id` int NOT NULL,
  `connection_group_id` int NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_group_id`,`permission`),
  KEY `guacamole_connection_group_permission_ibfk_1` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_group_permission_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_permission`
--

LOCK TABLES `guacamole_connection_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_history`
--

DROP TABLE IF EXISTS `guacamole_connection_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `connection_id` int DEFAULT NULL,
  `connection_name` varchar(128) NOT NULL,
  `sharing_profile_id` int DEFAULT NULL,
  `sharing_profile_name` varchar(128) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `connection_id` (`connection_id`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `connection_start_date` (`connection_id`,`start_date`),
  CONSTRAINT `guacamole_connection_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_2` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_3` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=627 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_history`
--

LOCK TABLES `guacamole_connection_history` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_history` DISABLE KEYS */;
INSERT INTO `guacamole_connection_history` VALUES (1,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:35:31','2024-04-09 07:35:32'),(2,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:35:37','2024-04-09 07:35:37'),(3,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:35:38','2024-04-09 07:35:39'),(4,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:35:44','2024-04-09 07:35:44'),(5,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:36:20','2024-04-09 07:36:21'),(6,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:36:30','2024-04-09 07:36:31'),(7,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:36:41','2024-04-09 07:36:42'),(8,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:37:08','2024-04-09 07:37:08'),(9,1,'guacadmin','172.17.0.1',1,'a',NULL,NULL,'2024-04-09 07:37:10','2024-04-09 07:37:10'),(10,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-09 07:40:08','2024-04-09 07:40:09'),(11,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-09 07:44:35',NULL),(12,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:30:17','2024-04-10 16:30:40'),(13,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:30:43','2024-04-10 16:30:51'),(14,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:30:52','2024-04-10 16:31:08'),(15,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:31:12','2024-04-10 16:31:18'),(16,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:31:37','2024-04-10 16:32:49'),(17,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:32:50','2024-04-10 16:33:12'),(18,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:33:16','2024-04-10 16:33:27'),(19,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:34:30','2024-04-10 16:37:05'),(20,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:40:01','2024-04-10 16:41:17'),(21,2,'user','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:42:43','2024-04-10 16:42:52'),(22,2,'user','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:43:06','2024-04-10 16:52:45'),(23,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:50:29','2024-04-10 16:50:33'),(24,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:50:56','2024-04-10 16:50:59'),(25,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:51:14','2024-04-10 16:54:46'),(26,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-10 16:54:49','2024-04-10 16:54:58'),(27,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:55:01','2024-04-10 16:55:03'),(28,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:55:19','2024-04-10 16:57:59'),(29,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:58:02','2024-04-10 16:58:04'),(30,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:59:01','2024-04-10 16:59:04'),(31,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 16:59:07','2024-04-10 17:01:31'),(32,2,'user','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-10 17:01:59','2024-04-10 17:02:08'),(33,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-13 19:36:28','2024-04-13 19:36:35'),(34,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-13 19:36:51','2024-04-13 19:36:57'),(35,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-13 19:37:13','2024-04-13 19:37:22'),(36,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-13 19:42:36','2024-04-13 19:42:42'),(37,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-13 21:58:39','2024-04-13 21:58:42'),(38,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:42:59','2024-04-14 07:43:34'),(39,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-14 07:43:21','2024-04-14 07:43:21'),(40,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:43:38','2024-04-14 07:44:44'),(41,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-14 07:44:04','2024-04-14 07:44:09'),(42,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-04-14 07:44:11','2024-04-14 07:44:49'),(43,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:45:04','2024-04-14 07:45:27'),(44,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:45:33','2024-04-14 07:45:42'),(45,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:47:36','2024-04-14 07:47:52'),(46,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:47:58','2024-04-14 07:48:13'),(47,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:48:15','2024-04-14 07:48:38'),(48,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:48:38','2024-04-14 07:49:01'),(49,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:49:17','2024-04-14 07:49:33'),(50,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-04-14 07:50:39','2024-04-14 08:57:24'),(311,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:30:16','2024-05-03 13:31:31'),(312,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-03 13:31:33','2024-05-03 13:31:40'),(313,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:31:55','2024-05-03 13:32:07'),(314,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:32:08','2024-05-03 13:32:12'),(315,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-03 13:32:14','2024-05-03 13:32:19'),(316,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-03 13:32:35','2024-05-03 13:34:48'),(317,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-03 13:34:51','2024-05-03 13:34:56'),(318,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:34:57','2024-05-03 13:35:20'),(319,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-03 13:35:28','2024-05-03 13:35:32'),(320,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:35:34','2024-05-03 13:35:46'),(321,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:35:47','2024-05-03 13:36:20'),(322,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:36:32','2024-05-03 13:37:07'),(323,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:37:17','2024-05-03 13:38:22'),(324,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:38:08','2024-05-03 13:39:13'),(325,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:38:49','2024-05-03 13:40:15'),(326,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:39:13','2024-05-03 13:39:43'),(327,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-03 13:42:29','2024-05-03 13:42:44'),(329,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-03 13:46:02','2024-05-03 13:49:54'),(341,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-04 08:05:50','2024-05-04 08:06:14'),(345,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 08:07:31','2024-05-04 08:07:44'),(357,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 08:18:56','2024-05-04 08:19:12'),(365,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 09:33:25','2024-05-04 09:33:53'),(366,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 09:33:54','2024-05-04 09:34:02'),(367,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 09:46:07','2024-05-04 10:26:40'),(380,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 16:40:35','2024-05-04 16:40:40'),(381,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 16:40:43','2024-05-04 16:40:46'),(382,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-04 16:40:48','2024-05-04 16:40:56'),(383,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 16:40:58','2024-05-04 16:41:02'),(412,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 17:33:56','2024-05-04 17:34:15'),(415,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:38:07','2024-05-04 18:38:25'),(416,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:40:24','2024-05-04 18:40:42'),(420,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 18:41:51','2024-05-04 18:41:54'),(421,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:41:59','2024-05-04 18:42:04'),(422,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:42:38','2024-05-04 18:42:41'),(424,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:43:32','2024-05-04 18:43:37'),(429,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:50:52','2024-05-04 18:50:57'),(430,1,'guacadmin','172.17.0.1',2,'some-ssh',NULL,NULL,'2024-05-04 18:50:59','2024-05-04 18:51:10'),(432,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 18:52:32','2024-05-04 18:52:35'),(433,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:52:39','2024-05-04 18:52:42'),(436,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 18:59:52','2024-05-04 18:59:55'),(445,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 19:24:41','2024-05-04 19:24:50'),(446,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 19:24:57','2024-05-04 19:25:05'),(451,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 19:26:40','2024-05-04 19:26:48'),(457,1,'guacadmin','172.17.0.1',4,'ball',NULL,NULL,'2024-05-04 19:29:19','2024-05-04 19:29:22'),(480,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 19:53:06','2024-05-04 19:53:16'),(481,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 19:53:18','2024-05-04 19:53:49'),(490,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 19:56:27','2024-05-04 19:56:30'),(524,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:11:58','2024-05-04 20:12:00'),(525,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:12:19','2024-05-04 20:13:26'),(526,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:13:30','2024-05-04 20:13:33'),(527,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:13:52','2024-05-04 20:13:56'),(528,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:14:00','2024-05-04 20:14:04'),(542,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:17:51','2024-05-04 20:18:25'),(545,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:18:53','2024-05-04 20:18:59'),(548,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:20:36','2024-05-04 20:20:45'),(555,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-04 20:28:19','2024-05-04 20:32:57'),(559,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-05 07:59:07','2024-05-05 07:59:19'),(567,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-05 08:05:33','2024-05-05 08:05:36'),(580,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-05 08:29:27','2024-05-05 08:36:52'),(583,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:15:09','2024-05-06 12:15:09'),(584,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:15:57','2024-05-06 12:15:58'),(585,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:15:58','2024-05-06 12:15:59'),(586,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:16:00','2024-05-06 12:16:01'),(587,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:16:06','2024-05-06 12:16:07'),(588,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:16:08','2024-05-06 12:16:08'),(590,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:16:32','2024-05-06 12:16:33'),(591,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 12:19:31','2024-05-06 12:19:53'),(592,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-06 12:19:56','2024-05-06 12:35:34'),(593,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-06 16:56:32','2024-05-06 16:56:36'),(594,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-06 16:56:38','2024-05-06 16:57:09'),(595,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:06:50','2024-05-10 15:06:57'),(596,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:07:13','2024-05-10 15:07:20'),(597,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:13:00','2024-05-10 15:13:15'),(598,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:13:31','2024-05-10 15:13:46'),(599,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:14:02','2024-05-10 15:14:17'),(600,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:14:33','2024-05-10 15:14:48'),(601,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:15:38','2024-05-10 15:15:54'),(602,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:15:57','2024-05-10 15:16:12'),(603,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:16:28','2024-05-10 15:16:43'),(604,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:16:59','2024-05-10 15:17:15'),(605,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:19:05','2024-05-10 15:19:20'),(606,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 15:19:30','2024-05-10 15:26:55'),(607,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 17:58:36','2024-05-10 17:58:52'),(608,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 17:58:53','2024-05-10 17:59:08'),(609,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 17:59:29','2024-05-10 17:59:41'),(610,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 17:59:42','2024-05-10 17:59:52'),(611,1,'guacadmin','172.17.0.1',1,'some-host',NULL,NULL,'2024-05-10 18:00:10','2024-05-10 18:00:15'),(612,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:00:17','2024-05-10 18:00:32'),(613,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:00:48','2024-05-10 18:01:28'),(614,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:01:32','2024-05-10 18:01:47'),(615,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:01:57','2024-05-10 18:02:12'),(616,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:02:27','2024-05-10 18:02:43'),(617,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:02:58','2024-05-10 18:03:13'),(618,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:03:29','2024-05-10 18:03:44'),(619,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:04:04','2024-05-10 18:09:19'),(620,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:09:25','2024-05-10 18:09:40'),(621,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:09:42','2024-05-10 18:09:57'),(622,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:10:13','2024-05-10 18:10:28'),(623,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:10:44','2024-05-10 18:10:59'),(624,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:11:01','2024-05-10 18:33:49'),(625,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:34:33','2024-05-10 18:34:48'),(626,1,'guacadmin','172.17.0.1',3,'rdesktop',NULL,NULL,'2024-05-10 18:35:04','2024-05-10 18:36:04');
/*!40000 ALTER TABLE `guacamole_connection_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_parameter`
--

DROP TABLE IF EXISTS `guacamole_connection_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_parameter` (
  `connection_id` int NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`parameter_name`),
  CONSTRAINT `guacamole_connection_parameter_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_parameter`
--

LOCK TABLES `guacamole_connection_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_parameter` DISABLE KEYS */;
INSERT INTO `guacamole_connection_parameter` VALUES (1,'cert-tofu','true'),(1,'hostname','172.17.0.9'),(1,'ignore-cert','true'),(1,'port','3389'),(1,'security','any'),(2,'hostname','172.17.0.6'),(2,'port','22'),(3,'hostname','192.168.100.2'),(3,'ignore-cert','true'),(3,'port','3389'),(3,'security','any');
/*!40000 ALTER TABLE `guacamole_connection_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_permission` (
  `entity_id` int NOT NULL,
  `connection_id` int NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_id`,`permission`),
  KEY `guacamole_connection_permission_ibfk_1` (`connection_id`),
  CONSTRAINT `guacamole_connection_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_permission_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_permission`
--

LOCK TABLES `guacamole_connection_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_permission` DISABLE KEYS */;
INSERT INTO `guacamole_connection_permission` VALUES (1,1,'READ'),(1,1,'UPDATE'),(1,1,'DELETE'),(1,1,'ADMINISTER'),(2,1,'READ'),(1,2,'READ'),(1,2,'UPDATE'),(1,2,'DELETE'),(1,2,'ADMINISTER'),(2,2,'READ'),(1,3,'READ'),(1,3,'UPDATE'),(1,3,'DELETE'),(1,3,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_connection_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_entity`
--

DROP TABLE IF EXISTS `guacamole_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_entity` (
  `entity_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `type` enum('USER','USER_GROUP') NOT NULL,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `guacamole_entity_name_scope` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_entity`
--

LOCK TABLES `guacamole_entity` WRITE;
/*!40000 ALTER TABLE `guacamole_entity` DISABLE KEYS */;
INSERT INTO `guacamole_entity` VALUES (1,'guacadmin','USER'),(2,'user','USER');
/*!40000 ALTER TABLE `guacamole_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile` (
  `sharing_profile_id` int NOT NULL AUTO_INCREMENT,
  `sharing_profile_name` varchar(128) NOT NULL,
  `primary_connection_id` int NOT NULL,
  PRIMARY KEY (`sharing_profile_id`),
  UNIQUE KEY `sharing_profile_name_primary` (`sharing_profile_name`,`primary_connection_id`),
  KEY `guacamole_sharing_profile_ibfk_1` (`primary_connection_id`),
  CONSTRAINT `guacamole_sharing_profile_ibfk_1` FOREIGN KEY (`primary_connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile`
--

LOCK TABLES `guacamole_sharing_profile` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_attribute`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_attribute` (
  `sharing_profile_id` int NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`attribute_name`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_attribute_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_attribute`
--

LOCK TABLES `guacamole_sharing_profile_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_parameter`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_parameter` (
  `sharing_profile_id` int NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`parameter_name`),
  CONSTRAINT `guacamole_sharing_profile_parameter_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_parameter`
--

LOCK TABLES `guacamole_sharing_profile_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_permission`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_permission` (
  `entity_id` int NOT NULL,
  `sharing_profile_id` int NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`sharing_profile_id`,`permission`),
  KEY `guacamole_sharing_profile_permission_ibfk_1` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_sharing_profile_permission_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_permission`
--

LOCK TABLES `guacamole_sharing_profile_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_system_permission`
--

DROP TABLE IF EXISTS `guacamole_system_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_system_permission` (
  `entity_id` int NOT NULL,
  `permission` enum('CREATE_CONNECTION','CREATE_CONNECTION_GROUP','CREATE_SHARING_PROFILE','CREATE_USER','CREATE_USER_GROUP','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`permission`),
  CONSTRAINT `guacamole_system_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_system_permission`
--

LOCK TABLES `guacamole_system_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_system_permission` DISABLE KEYS */;
INSERT INTO `guacamole_system_permission` VALUES (1,'CREATE_CONNECTION'),(1,'CREATE_CONNECTION_GROUP'),(1,'CREATE_SHARING_PROFILE'),(1,'CREATE_USER'),(1,'CREATE_USER_GROUP'),(1,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_system_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user`
--

DROP TABLE IF EXISTS `guacamole_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `entity_id` int NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `expired` tinyint(1) NOT NULL DEFAULT '0',
  `access_window_start` time DEFAULT NULL,
  `access_window_end` time DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `full_name` varchar(256) DEFAULT NULL,
  `email_address` varchar(256) DEFAULT NULL,
  `organization` varchar(256) DEFAULT NULL,
  `organizational_role` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `guacamole_user_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user`
--

LOCK TABLES `guacamole_user` WRITE;
/*!40000 ALTER TABLE `guacamole_user` DISABLE KEYS */;
INSERT INTO `guacamole_user` VALUES (1,1,UNHEX('CA458A7D494E3BE824F5E1E175A1556C0F8EEF2C2D7DF3633BEC4A29C4411960'),UNHEX('FE24ADC5E11E2B25288D1704ABE67A79E342ECC26064CE69C5B3177795A82264'),'2024-04-09 07:05:48',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,UNHEX('DDAC27FD9D9D0F0B5F958AEAD1737519CB8E7BAA48588AA6939C5730030C322B'),UNHEX('DEECFBA1D9078F92DD2B15B03944FD6BAFFF1B57F37EA2F7C73DD8758A95244F'),'2024-04-10 16:42:12',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `guacamole_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_attribute` (
  `user_id` int NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_id`,`attribute_name`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_attribute_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_attribute`
--

LOCK TABLES `guacamole_user_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group`
--

DROP TABLE IF EXISTS `guacamole_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group` (
  `user_group_id` int NOT NULL AUTO_INCREMENT,
  `entity_id` int NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `guacamole_user_group_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_group_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group`
--

LOCK TABLES `guacamole_user_group` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_attribute` (
  `user_group_id` int NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_group_id`,`attribute_name`),
  KEY `user_group_id` (`user_group_id`),
  CONSTRAINT `guacamole_user_group_attribute_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_attribute`
--

LOCK TABLES `guacamole_user_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_member`
--

DROP TABLE IF EXISTS `guacamole_user_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_member` (
  `user_group_id` int NOT NULL,
  `member_entity_id` int NOT NULL,
  PRIMARY KEY (`user_group_id`,`member_entity_id`),
  KEY `guacamole_user_group_member_entity_id` (`member_entity_id`),
  CONSTRAINT `guacamole_user_group_member_entity_id` FOREIGN KEY (`member_entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_member_parent_id` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_member`
--

LOCK TABLES `guacamole_user_group_member` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_permission`
--

DROP TABLE IF EXISTS `guacamole_user_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_permission` (
  `entity_id` int NOT NULL,
  `affected_user_group_id` int NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_group_id`,`permission`),
  KEY `guacamole_user_group_permission_affected_user_group` (`affected_user_group_id`),
  CONSTRAINT `guacamole_user_group_permission_affected_user_group` FOREIGN KEY (`affected_user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_permission`
--

LOCK TABLES `guacamole_user_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_history`
--

DROP TABLE IF EXISTS `guacamole_user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `user_start_date` (`user_id`,`start_date`),
  CONSTRAINT `guacamole_user_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_history`
--

LOCK TABLES `guacamole_user_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_history` DISABLE KEYS */;
INSERT INTO `guacamole_user_history` VALUES (1,1,'guacadmin','172.17.0.1','2024-04-09 07:16:27','2024-04-09 07:36:22'),(2,1,'guacadmin','172.17.0.1','2024-04-09 07:36:27','2024-04-09 07:39:36'),(3,1,'guacadmin','172.17.0.1','2024-04-09 07:39:40',NULL),(4,1,'guacadmin','172.17.0.1','2024-04-10 16:30:15','2024-04-10 16:37:14'),(5,1,'guacadmin','172.17.0.1','2024-04-10 16:37:25','2024-04-10 16:41:22'),(6,1,'guacadmin','172.17.0.1','2024-04-10 16:41:41','2024-04-10 16:50:47'),(7,2,'user','172.17.0.1','2024-04-10 16:42:23','2024-04-10 16:42:55'),(8,2,'user','172.17.0.1','2024-04-10 16:43:06','2024-04-10 17:01:23'),(9,1,'guacadmin','172.17.0.1','2024-04-10 16:50:52',NULL),(10,2,'user','172.17.0.1','2024-04-10 17:01:54',NULL),(11,1,'guacadmin','172.17.0.1','2024-04-13 19:36:25',NULL),(12,1,'guacadmin','172.17.0.1','2024-04-13 19:36:25',NULL),(13,1,'guacadmin','172.17.0.1','2024-04-13 19:36:28',NULL),(14,1,'guacadmin','172.17.0.1','2024-04-13 19:36:35',NULL),(15,1,'guacadmin','172.17.0.1','2024-04-13 19:36:57',NULL),(16,1,'guacadmin','172.17.0.1','2024-04-13 19:37:22',NULL),(17,1,'guacadmin','172.17.0.1','2024-04-13 19:42:42','2024-04-14 07:34:50'),(18,1,'guacadmin','172.17.0.1','2024-04-14 07:42:57',NULL),(19,1,'guacadmin','172.17.0.1','2024-04-14 07:42:57',NULL),(20,1,'guacadmin','172.17.0.1','2024-04-14 07:42:59',NULL),(21,1,'guacadmin','172.17.0.1','2024-04-14 07:43:21',NULL),(22,1,'guacadmin','172.17.0.1','2024-04-14 07:43:22',NULL),(23,1,'guacadmin','172.17.0.1','2024-04-14 07:43:23',NULL),(24,1,'guacadmin','172.17.0.1','2024-04-14 07:43:32',NULL),(25,1,'guacadmin','172.17.0.1','2024-04-14 07:43:38',NULL),(26,1,'guacadmin','172.17.0.1','2024-04-14 07:44:09',NULL),(27,1,'guacadmin','172.17.0.1','2024-04-14 07:44:49',NULL),(28,1,'guacadmin','172.17.0.1','2024-04-14 07:44:50',NULL),(29,1,'guacadmin','172.17.0.1','2024-04-14 07:45:04','2024-04-14 07:45:27'),(30,1,'guacadmin','172.17.0.1','2024-04-14 07:45:32',NULL),(31,1,'guacadmin','172.17.0.1','2024-04-14 07:45:32',NULL),(32,1,'guacadmin','172.17.0.1','2024-04-14 07:45:33',NULL),(33,1,'guacadmin','172.17.0.1','2024-04-14 07:45:42',NULL),(34,1,'guacadmin','172.17.0.1','2024-04-14 07:45:43',NULL),(35,1,'guacadmin','172.17.0.1','2024-04-14 07:47:36',NULL),(36,1,'guacadmin','172.17.0.1','2024-04-14 07:47:52',NULL),(37,1,'guacadmin','172.17.0.1','2024-04-14 07:47:53',NULL),(38,1,'guacadmin','172.17.0.1','2024-04-14 07:47:58',NULL),(39,1,'guacadmin','172.17.0.1','2024-04-14 07:48:13',NULL),(40,1,'guacadmin','172.17.0.1','2024-04-14 07:48:38',NULL),(41,1,'guacadmin','172.17.0.1','2024-04-14 07:49:01',NULL),(42,1,'guacadmin','172.17.0.1','2024-04-14 07:49:33','2024-04-14 07:49:36'),(43,1,'guacadmin','172.17.0.1','2024-04-14 07:49:40',NULL),(44,1,'guacadmin','172.17.0.1','2024-04-14 07:49:40',NULL),(45,1,'guacadmin','172.17.0.1','2024-04-14 07:49:44',NULL),(46,1,'guacadmin','172.17.0.1','2024-04-14 07:49:45',NULL),(47,1,'guacadmin','172.17.0.1','2024-04-14 07:50:07',NULL),(48,1,'guacadmin','172.17.0.1','2024-04-14 07:50:08',NULL),(49,1,'guacadmin','172.17.0.1','2024-04-14 07:50:10',NULL),(50,1,'guacadmin','172.17.0.1','2024-04-14 07:50:11',NULL),(51,1,'guacadmin','172.17.0.1','2024-04-14 07:50:35',NULL),(52,1,'guacadmin','172.17.0.1','2024-04-14 07:50:36',NULL),(53,1,'guacadmin','172.17.0.1','2024-04-14 07:50:37',NULL),(54,1,'guacadmin','172.17.0.1','2024-04-14 07:50:38',NULL),(55,1,'guacadmin','172.17.0.1','2024-05-03 10:43:24',NULL),(56,1,'guacadmin','172.17.0.1','2024-05-03 11:43:51',NULL),(57,1,'guacadmin','172.17.0.1','2024-05-03 12:22:13','2024-05-03 13:36:22'),(58,1,'guacadmin','172.17.0.1','2024-05-03 13:36:26','2024-05-03 14:49:59'),(59,1,'guacadmin','172.17.0.1','2024-05-03 13:38:07','2024-05-03 14:39:59'),(60,1,'guacadmin','172.17.0.1','2024-05-04 08:02:04','2024-05-04 11:27:26'),(61,1,'guacadmin','172.17.0.1','2024-05-04 16:30:50',NULL),(62,1,'guacadmin','172.17.0.1','2024-05-04 20:11:36','2024-05-04 21:54:06'),(63,1,'guacadmin','172.17.0.1','2024-05-05 07:58:48','2024-05-05 09:37:59'),(64,1,'guacadmin','172.17.0.1','2024-05-06 12:15:05','2024-05-06 13:35:56'),(65,1,'guacadmin','172.17.0.1','2024-05-06 16:56:13',NULL),(66,1,'guacadmin','172.17.0.1','2024-05-10 15:06:45',NULL),(67,1,'guacadmin','172.17.0.1','2024-05-10 17:58:27',NULL),(68,1,'guacadmin','172.17.0.1','2024-05-10 18:34:31',NULL);
/*!40000 ALTER TABLE `guacamole_user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_password_history`
--

DROP TABLE IF EXISTS `guacamole_user_password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_password_history` (
  `password_history_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  PRIMARY KEY (`password_history_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_password_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_password_history`
--

LOCK TABLES `guacamole_user_password_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_password_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_permission`
--

DROP TABLE IF EXISTS `guacamole_user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_permission` (
  `entity_id` int NOT NULL,
  `affected_user_id` int NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_id`,`permission`),
  KEY `guacamole_user_permission_ibfk_1` (`affected_user_id`),
  CONSTRAINT `guacamole_user_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_permission_ibfk_1` FOREIGN KEY (`affected_user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_permission`
--

LOCK TABLES `guacamole_user_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_permission` DISABLE KEYS */;
INSERT INTO `guacamole_user_permission` VALUES (1,1,'READ'),(1,1,'UPDATE'),(1,1,'ADMINISTER'),(1,2,'READ'),(1,2,'UPDATE'),(1,2,'DELETE'),(1,2,'ADMINISTER'),(2,2,'READ');
/*!40000 ALTER TABLE `guacamole_user_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-10 20:14:12
