-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: UNIVERSITY
-- ------------------------------------------------------
-- Server version	8.0.20-0ubuntu0.19.10.1

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
-- Table structure for table `BLOGTAG`
--

DROP DATABASE IF EXISTS `UNIVERSITY1`;
CREATE DATABASE UNIVERSITY1;
USE UNIVERSITY1;

DROP TABLE IF EXISTS `BLOGTAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BLOGTAG` (
  `Tag` varchar(255) DEFAULT NULL,
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `PostNumber` varchar(255) NOT NULL,
  PRIMARY KEY (`UserName`,`DNum`,`PostNumber`),
  CONSTRAINT `blogtag_fk` FOREIGN KEY (`UserName`, `DNum`, `PostNumber`) REFERENCES `POST` (`UserName`, `DNum`, `PostNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BLOGTAG`
--

LOCK TABLES `BLOGTAG` WRITE;
/*!40000 ALTER TABLE `BLOGTAG` DISABLE KEYS */;
/*!40000 ALTER TABLE `BLOGTAG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `COMMON_INTS`
--

DROP TABLE IF EXISTS `COMMON_INTS`;
/*!50001 DROP VIEW IF EXISTS `COMMON_INTS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `COMMON_INTS` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `CommonInterests`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `COMMON_SGS`
--

DROP TABLE IF EXISTS `COMMON_SGS`;
/*!50001 DROP VIEW IF EXISTS `COMMON_SGS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `COMMON_SGS` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `CommonStudyGroups`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `CONTAINS`
--

DROP TABLE IF EXISTS `CONTAINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTAINS` (
  `SubName` varchar(255) NOT NULL,
  `CourseID` int NOT NULL,
  PRIMARY KEY (`SubName`,`CourseID`),
  KEY `contains_courseid_fk` (`CourseID`),
  CONSTRAINT `contains_courseid_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contains_subname_fk` FOREIGN KEY (`SubName`) REFERENCES `SUBJECT` (`SubName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTAINS`
--

LOCK TABLES `CONTAINS` WRITE;
/*!40000 ALTER TABLE `CONTAINS` DISABLE KEYS */;
INSERT INTO `CONTAINS` VALUES ('Computer Science',1),('Mathematics',1),('Humanities',2),('Computer Science',3),('Computer Science',4);
/*!40000 ALTER TABLE `CONTAINS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COURSE`
--

DROP TABLE IF EXISTS `COURSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COURSE` (
  `CourseID` int NOT NULL AUTO_INCREMENT,
  `CourseName` varchar(255) DEFAULT NULL,
  `CourseOrg` varchar(255) DEFAULT NULL,
  `CoursePlatform` varchar(255) DEFAULT NULL,
  `CourseHours` int DEFAULT NULL,
  `CourseDuration` int DEFAULT NULL,
  `CourseRating` int DEFAULT NULL,
  PRIMARY KEY (`CourseID`),
  KEY `course_difficulty_fk` (`CourseName`,`CourseOrg`,`CoursePlatform`),
  CONSTRAINT `course_difficulty_fk` FOREIGN KEY (`CourseName`, `CourseOrg`, `CoursePlatform`) REFERENCES `COURSE_DIFFICULTY` (`CourseName`, `CourseOrg`, `CoursePlatform`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE`
--

LOCK TABLES `COURSE` WRITE;
/*!40000 ALTER TABLE `COURSE` DISABLE KEYS */;
INSERT INTO `COURSE` VALUES (1,'LINEAR ALGEBRA','MIT-OCW','YOUTUBE',8,8,NULL),(2,'CULTURE','NPTEL','Swayam',6,10,7),(3,'OPERATING SYSTEM','COURSERA','COURSERA',10,10,NULL),(4,'MACHINE LEARNING','EDX','EDX',12,6,NULL);
/*!40000 ALTER TABLE `COURSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COURSE_DIFFICULTY`
--

DROP TABLE IF EXISTS `COURSE_DIFFICULTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COURSE_DIFFICULTY` (
  `CourseName` varchar(255) NOT NULL,
  `CourseOrg` varchar(255) NOT NULL,
  `CourseDifficulty` varchar(255) DEFAULT NULL,
  `CoursePlatform` varchar(255) NOT NULL,
  PRIMARY KEY (`CourseName`,`CourseOrg`,`CoursePlatform`),
  CONSTRAINT `check_difficulty` CHECK ((`CourseDifficulty` in (_utf8mb4'Beginner',_utf8mb4'Intermediate',_utf8mb4'Expert')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE_DIFFICULTY`
--

LOCK TABLES `COURSE_DIFFICULTY` WRITE;
/*!40000 ALTER TABLE `COURSE_DIFFICULTY` DISABLE KEYS */;
INSERT INTO `COURSE_DIFFICULTY` VALUES ('CULTURE','NPTEL','Beginner','Swayam'),('LINEAR ALGEBRA','MIT-OCW','Expert','YOUTUBE'),('MACHINE LEARNING','EDX','Expert','EDX'),('OPERATING SYSTEM','COURSERA','Intermediate','COURSERA');
/*!40000 ALTER TABLE `COURSE_DIFFICULTY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COURSE_INSTRUCTOR`
--

DROP TABLE IF EXISTS `COURSE_INSTRUCTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COURSE_INSTRUCTOR` (
  `InstructorName` varchar(255) NOT NULL,
  `CourseID` int NOT NULL,
  PRIMARY KEY (`InstructorName`,`CourseID`),
  KEY `courseinstructor_fk` (`CourseID`),
  CONSTRAINT `courseinstructor_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE_INSTRUCTOR`
--

LOCK TABLES `COURSE_INSTRUCTOR` WRITE;
/*!40000 ALTER TABLE `COURSE_INSTRUCTOR` DISABLE KEYS */;
INSERT INTO `COURSE_INSTRUCTOR` VALUES ('PQR',1),('XYZ',1),('MNO',2),('ABC',3),('LMN',4);
/*!40000 ALTER TABLE `COURSE_INSTRUCTOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `FRIENDS`
--

DROP TABLE IF EXISTS `FRIENDS`;
/*!50001 DROP VIEW IF EXISTS `FRIENDS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FRIENDS` AS SELECT 
 1 AS `Friend2Name`,
 1 AS `Friend2DNum`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FRIENDS_SG`
--

DROP TABLE IF EXISTS `FRIENDS_SG`;
/*!50001 DROP VIEW IF EXISTS `FRIENDS_SG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FRIENDS_SG` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FRIENDS_SUBS`
--

DROP TABLE IF EXISTS `FRIENDS_SUBS`;
/*!50001 DROP VIEW IF EXISTS `FRIENDS_SUBS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FRIENDS_SUBS` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SubName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `FRIENDS_WITH`
--

DROP TABLE IF EXISTS `FRIENDS_WITH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FRIENDS_WITH` (
  `Friend1Name` varchar(255) NOT NULL,
  `Friend1DNum` int NOT NULL,
  `Friend2Name` varchar(255) NOT NULL,
  `Friend2DNum` int NOT NULL,
  `TimeStamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Friend1Name`,`Friend1DNum`,`Friend2Name`,`Friend2DNum`),
  KEY `friend2_fk` (`Friend2Name`,`Friend2DNum`),
  CONSTRAINT `friend1_fk` FOREIGN KEY (`Friend1Name`, `Friend1DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend2_fk` FOREIGN KEY (`Friend2Name`, `Friend2DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FRIENDS_WITH`
--

LOCK TABLES `FRIENDS_WITH` WRITE;
/*!40000 ALTER TABLE `FRIENDS_WITH` DISABLE KEYS */;
INSERT INTO `FRIENDS_WITH` VALUES ('user1',0,'user2',0,'2020-10-08 23:07:28'),('user1',0,'user3',0,'2020-10-09 00:54:26'),('user1',0,'user4',0,'2020-10-08 23:07:28'),('user1',0,'user7',0,'2020-10-08 23:07:28'),('user2',0,'user3',0,'2020-10-08 23:07:28'),('user2',0,'user7',0,'2020-10-08 23:07:28'),('user3',0,'user1',0,'2020-10-09 00:54:26'),('user4',0,'user5',0,'2020-10-08 23:07:28'),('user6',0,'user3',0,'2020-10-08 23:07:28');
/*!40000 ALTER TABLE `FRIENDS_WITH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `FinUserSG`
--

DROP TABLE IF EXISTS `FinUserSG`;
/*!50001 DROP VIEW IF EXISTS `FinUserSG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FinUserSG` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`,
 1 AS `Points`,
 1 AS `NumUsers`,
 1 AS `UserSgContrib`,
 1 AS `UserSgRating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Final`
--

DROP TABLE IF EXISTS `Final`;
/*!50001 DROP VIEW IF EXISTS `Final`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Final` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `CountGroups`,
 1 AS `Points`,
 1 AS `AvgContrib`,
 1 AS `AvgSgRating`,
 1 AS `AvgFrenz`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FinalBOTTOM`
--

DROP TABLE IF EXISTS `FinalBOTTOM`;
/*!50001 DROP VIEW IF EXISTS `FinalBOTTOM`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FinalBOTTOM` AS SELECT 
 1 AS `AvgGroupsB`,
 1 AS `AvgPointsB`,
 1 AS `AvgContribB`,
 1 AS `AvgRatingB`,
 1 AS `AvgFrenzB`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `FinalTOP`
--

DROP TABLE IF EXISTS `FinalTOP`;
/*!50001 DROP VIEW IF EXISTS `FinalTOP`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `FinalTOP` AS SELECT 
 1 AS `AvgGroupsT`,
 1 AS `AvgPointsT`,
 1 AS `AvgContribT`,
 1 AS `AvgRatingT`,
 1 AS `AvgFrenzT`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `HAS_INTEREST_IN`
--

DROP TABLE IF EXISTS `HAS_INTEREST_IN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HAS_INTEREST_IN` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `SubName` varchar(255) NOT NULL,
  `InterestType` varchar(255) NOT NULL,
  PRIMARY KEY (`UserName`,`DNum`,`SubName`),
  KEY `interest_fk` (`SubName`),
  CONSTRAINT `interest_fk` FOREIGN KEY (`SubName`) REFERENCES `SUBJECT` (`SubName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `interest_user_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CHK_InterestType` CHECK ((`InterestType` in (_utf8mb4'Research',_utf8mb4'Professional',_utf8mb4'Major',_utf8mb4'Minor',_utf8mb4'Casual')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HAS_INTEREST_IN`
--

LOCK TABLES `HAS_INTEREST_IN` WRITE;
/*!40000 ALTER TABLE `HAS_INTEREST_IN` DISABLE KEYS */;
INSERT INTO `HAS_INTEREST_IN` VALUES ('user1',0,'Computer Science','Research'),('user1',0,'Mathematics','Minor'),('user2',0,'Humanities','Major'),('user2',0,'Mathematics','Casual'),('user3',0,'Computer Science','Major'),('user3',0,'Mathematics','Casual'),('user4',0,'Computer Science','Research'),('user4',0,'Humanities','Casual'),('user5',0,'Humanities','Casual'),('user5',0,'Mathematics','Major'),('user6',0,'Computer Science','Major'),('user6',0,'Mathematics','Minor'),('user7',0,'Humanities','Major'),('user7',0,'Mathematics','Major');
/*!40000 ALTER TABLE `HAS_INTEREST_IN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KNOWS`
--

DROP TABLE IF EXISTS `KNOWS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KNOWS` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `LangCode` char(3) NOT NULL,
  `Fluency` varchar(255) NOT NULL,
  PRIMARY KEY (`UserName`,`DNum`,`LangCode`),
  KEY `knows_fk` (`LangCode`),
  CONSTRAINT `knows_fk` FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `knows_user_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CHK_Fluency` CHECK ((`Fluency` in (_utf8mb4'Elementary',_utf8mb4'Limited Working',_utf8mb4'Professional Working',_utf8mb4'Native')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KNOWS`
--

LOCK TABLES `KNOWS` WRITE;
/*!40000 ALTER TABLE `KNOWS` DISABLE KEYS */;
INSERT INTO `KNOWS` VALUES ('user1',0,'eng','Professional Working'),('user1',0,'ger','Elementary'),('user2',0,'eng','Native'),('user3',0,'eng','Professional Working'),('user3',0,'fre','Native'),('user4',0,'eng','Native'),('user4',0,'fre','Native'),('user5',0,'eng','Native'),('user6',0,'eng','Elementary'),('user7',0,'fre','Elementary');
/*!40000 ALTER TABLE `KNOWS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LANGUAGE`
--

DROP TABLE IF EXISTS `LANGUAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LANGUAGE` (
  `LangCode` char(3) NOT NULL,
  `LangName` varchar(255) NOT NULL,
  PRIMARY KEY (`LangCode`),
  UNIQUE KEY `LangName` (`LangName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LANGUAGE`
--

LOCK TABLES `LANGUAGE` WRITE;
/*!40000 ALTER TABLE `LANGUAGE` DISABLE KEYS */;
INSERT INTO `LANGUAGE` VALUES ('eng','ENGLISH'),('fre','FRENCH'),('ger','GERMAN');
/*!40000 ALTER TABLE `LANGUAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MEET`
--

DROP TABLE IF EXISTS `MEET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MEET` (
  `SgUrl` varchar(255) NOT NULL,
  `EventNum` int NOT NULL,
  `MeetTime` datetime DEFAULT NULL,
  `MeetDuration` int DEFAULT NULL,
  PRIMARY KEY (`SgUrl`,`EventNum`),
  CONSTRAINT `meet_has_upcoming_fk` FOREIGN KEY (`SgUrl`, `EventNum`) REFERENCES `SG_EVENT` (`SgUrl`, `EventNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MEET`
--

LOCK TABLES `MEET` WRITE;
/*!40000 ALTER TABLE `MEET` DISABLE KEYS */;
INSERT INTO `MEET` VALUES ('test.com',1,'2020-10-10 22:00:00',60);
/*!40000 ALTER TABLE `MEET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MEMBER_OF`
--

DROP TABLE IF EXISTS `MEMBER_OF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MEMBER_OF` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `SgUrl` varchar(255) NOT NULL,
  `UserSgRole` varchar(255) NOT NULL DEFAULT 'Member',
  `UserSgContrib` int NOT NULL DEFAULT '0',
  `UserSgRating` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserName`,`DNum`,`SgUrl`),
  KEY `member_sgurl_fk` (`SgUrl`),
  CONSTRAINT `member_sgurl_fk` FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `member_user_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_sgcontrib` CHECK (((`UserSgContrib` >= 0) and (`UserSgContrib` <= 10))),
  CONSTRAINT `check_sgrating` CHECK (((`UserSgRating` >= 0) and (`UserSgRating` <= 10))),
  CONSTRAINT `check_sgrole` CHECK ((`UserSgRole` in (_utf8mb4'Member',_utf8mb4'Admin')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MEMBER_OF`
--

LOCK TABLES `MEMBER_OF` WRITE;
/*!40000 ALTER TABLE `MEMBER_OF` DISABLE KEYS */;
INSERT INTO `MEMBER_OF` VALUES ('user1',0,'test.com','Member',9,9),('user3',0,'test.com','Member',8,7),('user6',0,'test.com','Member',9,4),('user7',0,'test.com','Admin',0,0);
/*!40000 ALTER TABLE `MEMBER_OF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTICIPATES_IN`
--

DROP TABLE IF EXISTS `PARTICIPATES_IN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARTICIPATES_IN` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `SgUrl` varchar(255) NOT NULL,
  `LangCode` char(3) NOT NULL,
  `CourseID` int NOT NULL,
  PRIMARY KEY (`SgUrl`,`UserName`,`DNum`,`LangCode`,`CourseID`),
  KEY `participates_user_fk` (`UserName`,`DNum`),
  KEY `participates_langcode_fk` (`LangCode`),
  KEY `participates_courseid_fk` (`CourseID`),
  CONSTRAINT `participates_courseid_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participates_langcode_fk` FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participates_sgurl_fk` FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participates_user_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARTICIPATES_IN`
--

LOCK TABLES `PARTICIPATES_IN` WRITE;
/*!40000 ALTER TABLE `PARTICIPATES_IN` DISABLE KEYS */;
INSERT INTO `PARTICIPATES_IN` VALUES ('user1',0,'test.com','eng',2),('user1',0,'test.com','fre',2),('user3',0,'test.com','eng',2),('user6',0,'test.com','fre',2),('user7',0,'test.com','fre',2);
/*!40000 ALTER TABLE `PARTICIPATES_IN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `PERFORMANCE`
--

DROP TABLE IF EXISTS `PERFORMANCE`;
/*!50001 DROP VIEW IF EXISTS `PERFORMANCE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PERFORMANCE` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `UserPerformance`,
 1 AS `CourseID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `PINS`
--

DROP TABLE IF EXISTS `PINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PINS` (
  `SgUrl` varchar(255) NOT NULL,
  `PinDetails` varchar(1000) DEFAULT '',
  PRIMARY KEY (`SgUrl`),
  CONSTRAINT `pins_sgurl_fk` FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PINS`
--

LOCK TABLES `PINS` WRITE;
/*!40000 ALTER TABLE `PINS` DISABLE KEYS */;
INSERT INTO `PINS` VALUES ('test.com','this');
/*!40000 ALTER TABLE `PINS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `POSS_SG`
--

DROP TABLE IF EXISTS `POSS_SG`;
/*!50001 DROP VIEW IF EXISTS `POSS_SG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `POSS_SG` AS SELECT 
 1 AS `SgUrl`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `POST`
--

DROP TABLE IF EXISTS `POST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `POST` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `TimeStamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PostNumber` varchar(255) NOT NULL,
  `PostTitle` varchar(255) DEFAULT NULL,
  `PostContent` varchar(255) DEFAULT NULL,
  `Type` varchar(255) NOT NULL,
  `ReviewRating` int DEFAULT NULL,
  `CourseID` int DEFAULT NULL,
  PRIMARY KEY (`UserName`,`DNum`,`PostNumber`),
  KEY `post_courseid_fk` (`CourseID`),
  CONSTRAINT `post_courseid_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `post_madeby_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_posttype` CHECK ((`Type` in (_utf8mb4'Review',_utf8mb4'Blog'))),
  CONSTRAINT `check_rating` CHECK (((`ReviewRating` >= 0) and (`ReviewRating` <= 10)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POST`
--

LOCK TABLES `POST` WRITE;
/*!40000 ALTER TABLE `POST` DISABLE KEYS */;
INSERT INTO `POST` VALUES ('user1',0,'2020-10-08 18:39:06','0','ReviewBob','Rievw ','Review',8,2),('user3',0,'2020-10-08 19:33:33','0','reees','reee','Review',7,2),('user6',0,'2020-10-08 18:41:36','0','reivewsss','thissss','Review',9,2),('user7',0,'2020-10-08 19:33:57','0','Reiv','fsdf','Review',2,2);
/*!40000 ALTER TABLE `POST` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `course_rating_trigger` AFTER INSERT ON `POST` FOR EACH ROW UPDATE COURSE 
  SET CourseRating = (SELECT AVG(ReviewRating) FROM POST WHERE COURSE.CourseID = POST.CourseID)
  WHERE CourseID = NEW.CourseID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PREREQUISITE`
--

DROP TABLE IF EXISTS `PREREQUISITE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PREREQUISITE` (
  `PrerequisiteOf` int NOT NULL,
  `HasPrerequisite` int NOT NULL,
  `PrerequisiteImportance` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PrerequisiteOf`,`HasPrerequisite`),
  KEY `has_prereq_fk` (`HasPrerequisite`),
  CONSTRAINT `has_prereq_fk` FOREIGN KEY (`HasPrerequisite`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `is_prereq_fk` FOREIGN KEY (`PrerequisiteOf`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_preqreq_importance` CHECK ((`PrerequisiteImportance` in (_utf8mb4'Essential',_utf8mb4'Helpful')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PREREQUISITE`
--

LOCK TABLES `PREREQUISITE` WRITE;
/*!40000 ALTER TABLE `PREREQUISITE` DISABLE KEYS */;
INSERT INTO `PREREQUISITE` VALUES (4,1,'Essential');
/*!40000 ALTER TABLE `PREREQUISITE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `RATING`
--

DROP TABLE IF EXISTS `RATING`;
/*!50001 DROP VIEW IF EXISTS `RATING`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `RATING` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `ReviewRating`,
 1 AS `CourseID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `REQ_SG`
--

DROP TABLE IF EXISTS `REQ_SG`;
/*!50001 DROP VIEW IF EXISTS `REQ_SG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `REQ_SG` AS SELECT 
 1 AS `SgUrl`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `SCORE`
--

DROP TABLE IF EXISTS `SCORE`;
/*!50001 DROP VIEW IF EXISTS `SCORE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `SCORE` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `Points`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `SG`
--

DROP TABLE IF EXISTS `SG`;
/*!50001 DROP VIEW IF EXISTS `SG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `SG` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`,
 1 AS `Points`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `SGUSERS`
--

DROP TABLE IF EXISTS `SGUSERS`;
/*!50001 DROP VIEW IF EXISTS `SGUSERS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `SGUSERS` AS SELECT 
 1 AS `SgUrl`,
 1 AS `NumUsers`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `SG_EVENT`
--

DROP TABLE IF EXISTS `SG_EVENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SG_EVENT` (
  `SgUrl` varchar(255) NOT NULL,
  `EventNum` int NOT NULL,
  `EventTitle` varchar(255) DEFAULT 'No Title',
  `EventInfo` varchar(255) DEFAULT 'No Information',
  PRIMARY KEY (`SgUrl`,`EventNum`),
  CONSTRAINT `event_sgurl_fk` FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SG_EVENT`
--

LOCK TABLES `SG_EVENT` WRITE;
/*!40000 ALTER TABLE `SG_EVENT` DISABLE KEYS */;
INSERT INTO `SG_EVENT` VALUES ('test.com',0,'discussion','meet'),('test.com',1,'this','that'),('test.com',2,'that','this'),('test.com',3,'that','that');
/*!40000 ALTER TABLE `SG_EVENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STUDY_GROUP`
--

DROP TABLE IF EXISTS `STUDY_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STUDY_GROUP` (
  `SgUrl` varchar(255) NOT NULL,
  `SgCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SgUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SgStatus` varchar(255) NOT NULL DEFAULT 'Planned',
  PRIMARY KEY (`SgUrl`),
  CONSTRAINT `check_sgdatesanity` CHECK ((`SgCreated` <= `SgUpdated`)),
  CONSTRAINT `check_sgstatus` CHECK ((`SgStatus` in (_utf8mb4'Completed',_utf8mb4'Active',_utf8mb4'Planned')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STUDY_GROUP`
--

LOCK TABLES `STUDY_GROUP` WRITE;
/*!40000 ALTER TABLE `STUDY_GROUP` DISABLE KEYS */;
INSERT INTO `STUDY_GROUP` VALUES ('test.com','2020-10-08 17:42:14','2020-10-08 17:42:14','Planned');
/*!40000 ALTER TABLE `STUDY_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBJECT`
--

DROP TABLE IF EXISTS `SUBJECT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUBJECT` (
  `SubName` varchar(255) NOT NULL,
  PRIMARY KEY (`SubName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBJECT`
--

LOCK TABLES `SUBJECT` WRITE;
/*!40000 ALTER TABLE `SUBJECT` DISABLE KEYS */;
INSERT INTO `SUBJECT` VALUES ('Computer Science'),('Humanities'),('Mathematics');
/*!40000 ALTER TABLE `SUBJECT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `SUBS`
--

DROP TABLE IF EXISTS `SUBS`;
/*!50001 DROP VIEW IF EXISTS `SUBS`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `SUBS` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SubName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `SgUrls`
--

DROP TABLE IF EXISTS `SgUrls`;
/*!50001 DROP VIEW IF EXISTS `SgUrls`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `SgUrls` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `TAKES`
--

DROP TABLE IF EXISTS `TAKES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TAKES` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `CourseID` int NOT NULL,
  `UserPerformance` float NOT NULL DEFAULT '5',
  `UserNumHours` int NOT NULL DEFAULT '0',
  `UserProgress` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserName`,`DNum`,`CourseID`),
  KEY `takes_courseid_fk` (`CourseID`),
  CONSTRAINT `takes_courseid_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `takes_user_fk` FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_performance` CHECK (((`UserPerformance` >= 0) and (`UserPerformance` <= 10))),
  CONSTRAINT `check_progress` CHECK (((`UserProgress` >= 0) and (`UserProgress` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TAKES`
--

LOCK TABLES `TAKES` WRITE;
/*!40000 ALTER TABLE `TAKES` DISABLE KEYS */;
INSERT INTO `TAKES` VALUES ('user1',0,2,7,0,0),('user3',0,2,0,0,0),('user6',0,2,9,0,0),('user7',0,2,5,0,0);
/*!40000 ALTER TABLE `TAKES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TARGET`
--

DROP TABLE IF EXISTS `TARGET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TARGET` (
  `SgUrl` varchar(255) NOT NULL,
  `EventNum` int NOT NULL,
  `TargetSetDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `TargetDeadline` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`SgUrl`,`EventNum`),
  CONSTRAINT `target_has_upcoming_fk` FOREIGN KEY (`SgUrl`, `EventNum`) REFERENCES `SG_EVENT` (`SgUrl`, `EventNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TARGET`
--

LOCK TABLES `TARGET` WRITE;
/*!40000 ALTER TABLE `TARGET` DISABLE KEYS */;
INSERT INTO `TARGET` VALUES ('test.com',3,'2020-10-08 18:11:19','2020-10-10 16:30:00');
/*!40000 ALTER TABLE `TARGET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `TempBOTTOM`
--

DROP TABLE IF EXISTS `TempBOTTOM`;
/*!50001 DROP VIEW IF EXISTS `TempBOTTOM`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `TempBOTTOM` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `CountGroups`,
 1 AS `Points`,
 1 AS `AvgContrib`,
 1 AS `AvgSgRating`,
 1 AS `AvgFrenz`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `TempTOP`
--

DROP TABLE IF EXISTS `TempTOP`;
/*!50001 DROP VIEW IF EXISTS `TempTOP`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `TempTOP` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `CountGroups`,
 1 AS `Points`,
 1 AS `AvgContrib`,
 1 AS `AvgSgRating`,
 1 AS `AvgFrenz`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UFrenz`
--

DROP TABLE IF EXISTS `UFrenz`;
/*!50001 DROP VIEW IF EXISTS `UFrenz`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UFrenz` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `FrName`,
 1 AS `FrDNum`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `USED_FOR`
--

DROP TABLE IF EXISTS `USED_FOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USED_FOR` (
  `LangCode` char(3) NOT NULL,
  `CourseID` int NOT NULL,
  `SubDub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LangCode`,`CourseID`),
  KEY `used_for_courseid_fk` (`CourseID`),
  CONSTRAINT `used_for_courseid_fk` FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `used_for_langcode_fk` FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_subdum` CHECK ((`SubDub` in (_utf8mb4'Sub',_utf8mb4'Dub',_utf8mb4'Native')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USED_FOR`
--

LOCK TABLES `USED_FOR` WRITE;
/*!40000 ALTER TABLE `USED_FOR` DISABLE KEYS */;
INSERT INTO `USED_FOR` VALUES ('eng',1,'Native'),('eng',2,'Native'),('eng',3,'Native'),('eng',4,'Native'),('fre',2,'Sub'),('ger',3,'Dub');
/*!40000 ALTER TABLE `USED_FOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER`
--

DROP TABLE IF EXISTS `USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER` (
  `UserName` varchar(255) NOT NULL,
  `DNum` int NOT NULL,
  `FName` varchar(255) NOT NULL,
  `MName` varchar(255) DEFAULT NULL,
  `SName` varchar(255) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`UserName`,`DNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER`
--

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;
INSERT INTO `USER` VALUES ('user1',0,'SHASWAT',NULL,'GOEL','2001-01-01','abc@gmail.com','1'),('user2',0,'ADITYA',NULL,'HARI','2000-01-01','abc@yahoo.com','2'),('user3',0,'PRINCE',NULL,'VARSHNEY','2000-08-05','abc123@gmail.com','3'),('user4',0,'Tom',NULL,'Riddle','2000-08-05','test@gmail.com','4'),('user5',0,'Harry',NULL,'Potter','2000-08-05','test1@gmail.com','5'),('user6',0,'Danny','de','Vito','2000-08-05','test2@gmail.com','6'),('user7',0,'Katniss',NULL,'Everdeen','2000-08-05','test3@gmail.com','7');
/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `USgFrenz`
--

DROP TABLE IF EXISTS `USgFrenz`;
/*!50001 DROP VIEW IF EXISTS `USgFrenz`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `USgFrenz` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`,
 1 AS `Points`,
 1 AS `NumUsers`,
 1 AS `UserSgContrib`,
 1 AS `UserSgRating`,
 1 AS `NumFrenz`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UserSG`
--

DROP TABLE IF EXISTS `UserSG`;
/*!50001 DROP VIEW IF EXISTS `UserSG`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserSG` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`,
 1 AS `SgUrl`,
 1 AS `Points`,
 1 AS `UserSgContrib`,
 1 AS `UserSgRating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UserTaken`
--

DROP TABLE IF EXISTS `UserTaken`;
/*!50001 DROP VIEW IF EXISTS `UserTaken`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserTaken` AS SELECT 
 1 AS `UserName`,
 1 AS `DNum`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `COMMON_INTS`
--

/*!50001 DROP VIEW IF EXISTS `COMMON_INTS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `COMMON_INTS` AS select `FRIENDS_SUBS`.`UserName` AS `UserName`,`FRIENDS_SUBS`.`DNum` AS `DNum`,count(0) AS `CommonInterests` from `FRIENDS_SUBS` where `FRIENDS_SUBS`.`SubName` in (select `SUBS`.`SubName` from `SUBS`) group by `FRIENDS_SUBS`.`UserName`,`FRIENDS_SUBS`.`DNum` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `COMMON_SGS`
--

/*!50001 DROP VIEW IF EXISTS `COMMON_SGS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `COMMON_SGS` AS select `FRIENDS_SG`.`UserName` AS `UserName`,`FRIENDS_SG`.`DNum` AS `DNum`,count(0) AS `CommonStudyGroups` from `FRIENDS_SG` where `FRIENDS_SG`.`SgUrl` in (select `SgUrls`.`SgUrl` from `SgUrls`) group by `FRIENDS_SG`.`UserName`,`FRIENDS_SG`.`DNum` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FRIENDS`
--

/*!50001 DROP VIEW IF EXISTS `FRIENDS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FRIENDS` AS select `FRIENDS_WITH`.`Friend2Name` AS `Friend2Name`,`FRIENDS_WITH`.`Friend2DNum` AS `Friend2DNum` from `FRIENDS_WITH` where ((`FRIENDS_WITH`.`Friend1Name` = 'user1') and (`FRIENDS_WITH`.`Friend2DNum` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FRIENDS_SG`
--

/*!50001 DROP VIEW IF EXISTS `FRIENDS_SG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FRIENDS_SG` AS select `PARTICIPATES_IN`.`UserName` AS `UserName`,`PARTICIPATES_IN`.`DNum` AS `DNum`,`PARTICIPATES_IN`.`SgUrl` AS `SgUrl` from (`PARTICIPATES_IN` join `FRIENDS` on(((`PARTICIPATES_IN`.`UserName` = `FRIENDS`.`Friend2Name`) and (`PARTICIPATES_IN`.`DNum` = `FRIENDS`.`Friend2DNum`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FRIENDS_SUBS`
--

/*!50001 DROP VIEW IF EXISTS `FRIENDS_SUBS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FRIENDS_SUBS` AS select `HAS_INTEREST_IN`.`UserName` AS `UserName`,`HAS_INTEREST_IN`.`DNum` AS `DNum`,`HAS_INTEREST_IN`.`SubName` AS `SubName` from (`HAS_INTEREST_IN` join `FRIENDS` on(((`HAS_INTEREST_IN`.`UserName` = `FRIENDS`.`Friend2Name`) and (`HAS_INTEREST_IN`.`DNum` = `FRIENDS`.`Friend2DNum`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FinUserSG`
--

/*!50001 DROP VIEW IF EXISTS `FinUserSG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FinUserSG` AS select `UserSG`.`UserName` AS `UserName`,`UserSG`.`DNum` AS `DNum`,`UserSG`.`SgUrl` AS `SgUrl`,`UserSG`.`Points` AS `Points`,`SGUSERS`.`NumUsers` AS `NumUsers`,`UserSG`.`UserSgContrib` AS `UserSgContrib`,`UserSG`.`UserSgRating` AS `UserSgRating` from (`UserSG` join `SGUSERS` on((`UserSG`.`SgUrl` = `SGUSERS`.`SgUrl`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Final`
--

/*!50001 DROP VIEW IF EXISTS `Final`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Final` AS select `USgFrenz`.`UserName` AS `UserName`,`USgFrenz`.`DNum` AS `DNum`,count(`USgFrenz`.`SgUrl`) AS `CountGroups`,avg(`USgFrenz`.`Points`) AS `Points`,avg(`USgFrenz`.`UserSgContrib`) AS `AvgContrib`,avg(`USgFrenz`.`UserSgRating`) AS `AvgSgRating`,avg(`USgFrenz`.`NumFrenz`) AS `AvgFrenz` from `USgFrenz` group by `USgFrenz`.`UserName`,`USgFrenz`.`DNum` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FinalBOTTOM`
--

/*!50001 DROP VIEW IF EXISTS `FinalBOTTOM`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FinalBOTTOM` AS select avg(`TempBOTTOM`.`CountGroups`) AS `AvgGroupsB`,avg(`TempBOTTOM`.`Points`) AS `AvgPointsB`,avg(`TempBOTTOM`.`AvgContrib`) AS `AvgContribB`,avg(`TempBOTTOM`.`AvgSgRating`) AS `AvgRatingB`,avg(`TempBOTTOM`.`AvgFrenz`) AS `AvgFrenzB` from `TempBOTTOM` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FinalTOP`
--

/*!50001 DROP VIEW IF EXISTS `FinalTOP`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FinalTOP` AS select avg(`TempTOP`.`CountGroups`) AS `AvgGroupsT`,avg(`TempTOP`.`Points`) AS `AvgPointsT`,avg(`TempTOP`.`AvgContrib`) AS `AvgContribT`,avg(`TempTOP`.`AvgSgRating`) AS `AvgRatingT`,avg(`TempTOP`.`AvgFrenz`) AS `AvgFrenzT` from `TempTOP` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PERFORMANCE`
--

/*!50001 DROP VIEW IF EXISTS `PERFORMANCE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `PERFORMANCE` AS select `TAKES`.`UserName` AS `UserName`,`TAKES`.`DNum` AS `DNum`,`TAKES`.`UserPerformance` AS `UserPerformance`,`TAKES`.`CourseID` AS `CourseID` from `TAKES` where (`TAKES`.`CourseID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `POSS_SG`
--

/*!50001 DROP VIEW IF EXISTS `POSS_SG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `POSS_SG` AS select distinct `REQ_SG`.`SgUrl` AS `SgUrl` from (`REQ_SG` join `STUDY_GROUP` on((`REQ_SG`.`SgUrl` = `STUDY_GROUP`.`SgUrl`))) where ((`STUDY_GROUP`.`SgStatus` = 'Active') or (`STUDY_GROUP`.`SgStatus` = 'Planned')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `RATING`
--

/*!50001 DROP VIEW IF EXISTS `RATING`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `RATING` AS select `POST`.`UserName` AS `UserName`,`POST`.`DNum` AS `DNum`,`POST`.`ReviewRating` AS `ReviewRating`,`POST`.`CourseID` AS `CourseID` from `POST` where ((`POST`.`CourseID` = 2) and (`POST`.`ReviewRating` is not null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `REQ_SG`
--

/*!50001 DROP VIEW IF EXISTS `REQ_SG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `REQ_SG` AS select distinct `PARTICIPATES_IN`.`SgUrl` AS `SgUrl` from `PARTICIPATES_IN` where (`PARTICIPATES_IN`.`CourseID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `SCORE`
--

/*!50001 DROP VIEW IF EXISTS `SCORE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SCORE` AS select `RATING`.`UserName` AS `UserName`,`RATING`.`DNum` AS `DNum`,((`PERFORMANCE`.`UserPerformance` + `RATING`.`ReviewRating`) / 2) AS `Points` from (`RATING` join `PERFORMANCE` on(((`RATING`.`UserName` = `PERFORMANCE`.`UserName`) and (`RATING`.`DNum` = `PERFORMANCE`.`DNum`) and (`RATING`.`CourseID` = `PERFORMANCE`.`CourseID`)))) where (`RATING`.`CourseID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `SG`
--

/*!50001 DROP VIEW IF EXISTS `SG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SG` AS select `SCORE`.`UserName` AS `UserName`,`SCORE`.`DNum` AS `DNum`,`PARTICIPATES_IN`.`SgUrl` AS `SgUrl`,`SCORE`.`Points` AS `Points` from (`SCORE` join `PARTICIPATES_IN` on(((`SCORE`.`UserName` = `PARTICIPATES_IN`.`UserName`) and (`SCORE`.`DNum` = `PARTICIPATES_IN`.`DNum`)))) where (`PARTICIPATES_IN`.`CourseID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `SGUSERS`
--

/*!50001 DROP VIEW IF EXISTS `SGUSERS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SGUSERS` AS select `MEMBER_OF`.`SgUrl` AS `SgUrl`,count(distinct concat(`MEMBER_OF`.`UserName`,`MEMBER_OF`.`DNum`)) AS `NumUsers` from `MEMBER_OF` group by `MEMBER_OF`.`SgUrl` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `SUBS`
--

/*!50001 DROP VIEW IF EXISTS `SUBS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SUBS` AS select `HAS_INTEREST_IN`.`UserName` AS `UserName`,`HAS_INTEREST_IN`.`DNum` AS `DNum`,`HAS_INTEREST_IN`.`SubName` AS `SubName` from `HAS_INTEREST_IN` where ((`HAS_INTEREST_IN`.`UserName` = 'user1') and (`HAS_INTEREST_IN`.`DNum` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `SgUrls`
--

/*!50001 DROP VIEW IF EXISTS `SgUrls`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SgUrls` AS select `PARTICIPATES_IN`.`UserName` AS `UserName`,`PARTICIPATES_IN`.`DNum` AS `DNum`,`PARTICIPATES_IN`.`SgUrl` AS `SgUrl` from `PARTICIPATES_IN` where ((`PARTICIPATES_IN`.`UserName` = 'user1') and (`PARTICIPATES_IN`.`DNum` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TempBOTTOM`
--

/*!50001 DROP VIEW IF EXISTS `TempBOTTOM`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TempBOTTOM` AS select `Final`.`UserName` AS `UserName`,`Final`.`DNum` AS `DNum`,`Final`.`CountGroups` AS `CountGroups`,`Final`.`Points` AS `Points`,`Final`.`AvgContrib` AS `AvgContrib`,`Final`.`AvgSgRating` AS `AvgSgRating`,`Final`.`AvgFrenz` AS `AvgFrenz` from `Final` order by `Final`.`Points` limit 2 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TempTOP`
--

/*!50001 DROP VIEW IF EXISTS `TempTOP`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TempTOP` AS select `Final`.`UserName` AS `UserName`,`Final`.`DNum` AS `DNum`,`Final`.`CountGroups` AS `CountGroups`,`Final`.`Points` AS `Points`,`Final`.`AvgContrib` AS `AvgContrib`,`Final`.`AvgSgRating` AS `AvgSgRating`,`Final`.`AvgFrenz` AS `AvgFrenz` from `Final` order by `Final`.`Points` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UFrenz`
--

/*!50001 DROP VIEW IF EXISTS `UFrenz`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `UFrenz` AS select `UserTaken`.`UserName` AS `UserName`,`UserTaken`.`DNum` AS `DNum`,`FRIENDS_WITH`.`Friend2Name` AS `FrName`,`FRIENDS_WITH`.`Friend2DNum` AS `FrDNum` from (`UserTaken` join `FRIENDS_WITH`) where ((`FRIENDS_WITH`.`Friend1Name` = `UserTaken`.`UserName`) and (`FRIENDS_WITH`.`Friend1DNum` = `UserTaken`.`DNum`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `USgFrenz`
--

/*!50001 DROP VIEW IF EXISTS `USgFrenz`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `USgFrenz` AS select `UFrenz`.`UserName` AS `UserName`,`UFrenz`.`DNum` AS `DNum`,`FinUserSG`.`SgUrl` AS `SgUrl`,avg(`FinUserSG`.`Points`) AS `Points`,`FinUserSG`.`NumUsers` AS `NumUsers`,`FinUserSG`.`UserSgContrib` AS `UserSgContrib`,`FinUserSG`.`UserSgRating` AS `UserSgRating`,count(distinct concat(`UFrenz`.`FrName`,`UFrenz`.`FrDNum`)) AS `NumFrenz` from (`UFrenz` join `FinUserSG` on(((`UFrenz`.`UserName` = `FinUserSG`.`UserName`) and (`UFrenz`.`DNum` = `FinUserSG`.`DNum`)))) group by `UFrenz`.`UserName`,`UFrenz`.`DNum`,`FinUserSG`.`SgUrl` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserSG`
--

/*!50001 DROP VIEW IF EXISTS `UserSG`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `UserSG` AS select `SG`.`UserName` AS `UserName`,`SG`.`DNum` AS `DNum`,`SG`.`SgUrl` AS `SgUrl`,`SG`.`Points` AS `Points`,`MEMBER_OF`.`UserSgContrib` AS `UserSgContrib`,`MEMBER_OF`.`UserSgRating` AS `UserSgRating` from (`SG` join `MEMBER_OF` on(((`SG`.`UserName` = `MEMBER_OF`.`UserName`) and (`SG`.`DNum` = `MEMBER_OF`.`DNum`) and (`SG`.`SgUrl` = `MEMBER_OF`.`SgUrl`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserTaken`
--

/*!50001 DROP VIEW IF EXISTS `UserTaken`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`temp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `UserTaken` AS select `FinUserSG`.`UserName` AS `UserName`,`FinUserSG`.`DNum` AS `DNum` from `FinUserSG` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-09  1:08:07
