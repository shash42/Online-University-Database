DROP DATABASE IF EXISTS `UNIVERSITY`;
CREATE DATABASE UNIVERSITY;
USE UNIVERSITY;
CREATE TABLE `USER` (
  `UserName` varchar(255),
  `DNum` int,
  `FName` varchar(255),
  `MName` varchar(255),
  `SName` varchar(255),
  `DOB` TimeStamp,
  `Email` varchar(255),
  `UContribution` float,
  PRIMARY KEY (`UserName`, `DNum`)
);

CREATE TABLE `SUBJECT` (
  `SubName` varchar(255) PRIMARY KEY,
  `NumCourse` int,
  `SPopularity` int
);

CREATE TABLE `LANGUAGE` (
  `LangCode` char(3) PRIMARY KEY,
  `LangName` varchar(255)
);

CREATE TABLE `KNOWS` (
  `UserName` varchar(255),
  `DNum` int,
  `LangCode` char(3),
  `Fluency` varchar(255),
  PRIMARY KEY (`UserName`, `DNum`, `LangCode`)
);

CREATE TABLE `HAS_INTEREST_IN` (
  `UserName` varchar(255),
  `DNum` int,
  `SubName` varchar(255),
  `InterestType` varchar(255),
  PRIMARY KEY (`UserName`, `DNum`, `SubName`)
);

CREATE TABLE `FRIENDS_WITH` (
  `Friend1Name` varchar(255),
  `Friend1DNum` int,
  `Friend2Name` varchar(255),
  `Friend2DNum` int,
  `TimeStamp` TimeStamp,
  `NumStudyGroups` int,
  `NumCommonCourses` int,
  PRIMARY KEY (`Friend1Name`, `Friend1DNum`, `Friend2Name`, `Friend2DNum`)
);

CREATE TABLE `COURSE` (
  `CourseID` int PRIMARY KEY,
  `CourseName` varchar(255),
  `CourseOrg` varchar(255),
  `CoursePlatform` varchar(255),
  `CourseHours` int,
  `CourseDuration` int,
  `CourseRating` int
);

CREATE TABLE `COURSE_DIFFICULTY` (
  `CourseName` varchar(255),
  `CourseOrg` varchar(255),
  `CourseDifficulty` varchar(255),
  `CoursePlatform` varchar(255),
  PRIMARY KEY (`CourseName`, `CourseOrg`, `CoursePlatform`)
);

CREATE TABLE `COURSE_INSTRUCTOR` (
  `InstructorName` varchar(255),
  `CourseID` int,
  PRIMARY KEY (`InstructorName`, `CourseID`)
);

CREATE TABLE `CONTAINS` (
  `SubName` varchar(255),
  `CourseID` int,
  PRIMARY KEY (`SubName`, `CourseID`)
);

CREATE TABLE `USED_FOR` (
  `LangCode` char(3),
  `CourseID` int,
  `SubDub` varchar(255),
  CONSTRAINT check_subdum CHECK (`SubDub` IN ("Subs", "Dubs")),
  PRIMARY KEY (`LangCode`, `CourseID`)
);

CREATE TABLE `PREREQUISITE` (
  `PrerequisiteOf` int,
  `HasPrerequisite` int,
  `PrerequisiteImportance` varchar(255),
  CONSTRAINT check_preqreq_importance CHECK(`PrerequisiteImportance` IN ("Essential", "Helpful")),
  PRIMARY KEY (`PrerequisiteOf`, `HasPrerequisite`)
);

CREATE TABLE `POST` (
  `UserName` varchar(255),
  `DNum` int,
  `TimeStamp` TimeStamp,
  `PostNumber` varchar(255),
  `PostTitle` varchar(255),
  `PostContent` varchar(255),
  `Type` varchar(255),
  `ReviewRating` int,
  CONSTRAINT check_rating CHECK ((`ReviewRating` >= 0 AND `ReviewRating` <= 10)), 
  `CourseID` int,
  PRIMARY KEY (`UserName`, `DNum`, `PostNumber`)
);

CREATE TABLE `BLOGTAG` (
  `Tag` varchar(255),
  `UserName` varchar(255),
  `DNum` int,
  `PostNumber` varchar(255),
  PRIMARY KEY (`UserName`, `DNum`, `PostNumber`)
);

CREATE TABLE `STUDY_GROUP` (
  `SgUrl` varchar(255) PRIMARY KEY,
  `SgCreated` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SgUpdated` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT check_sgdatesanity CHECK (`SgCreated` <= `SgUpdated`) -- AND `SgUpdated` <= CURRENT_TIMESTAP gives syntax error
);

CREATE TABLE `PINS` (
  `SgUrl` varchar(255) PRIMARY KEY,
  `PinDetails` varchar(255) DEFAULT ""
);

CREATE TABLE `SG_EVENT` (
  `SgUrl` varchar(255),
  `EventNum` int NOT NULL,
  `EventTitle` varchar(255) DEFAULT "No Title",
  `EventInfo` varchar(255) DEFAULT "No Information",
  `Type` varchar(255) NOT NULL DEFAULT "MEET",
  PRIMARY KEY (`SgUrl`, `EventNum`),
  CONSTRAINT check_type CHECK (`Type` IN ("MEET", "TARGET"))
);

CREATE TABLE `MEET` (
  `SgUrl` varchar(255),
  `EventNum` int,
  `MeetTime` TimeStamp,
  `MeetDuration` int,
  PRIMARY KEY (`SgUrl`, `EventNum`)
);

CREATE TABLE `TARGET` (
  `SgUrl` varchar(255),
  `EventNum` int,
  `TargetSetDate` TimeStamp DEFAULT CURRENT_TIMESTAMP,
  `TargetDeadline` TimeStamp,
  PRIMARY KEY (`SgUrl`, `EventNum`)
  -- CONSTRAINT check_targetsanity CHECK (`TargetSetDate` <= CURRENT_TIMESTAMP) Gives syntax error
);

CREATE TABLE `PARTICIPATES_IN` (
  `UserName` varchar(255),
  `DNum` int,
  `SgUrl` varchar(255),
  `LangCode` char(3),
  `CourseID` int,
  `UserSgRole` varchar(255) NOT NULL DEFAULT "Member",
  `UserSgContrib` int NOT NULL DEFAULT 0,
  `UserSgRating` int NOT NULL DEFAULT 0,
  `UserPerformance` float NOT NULL DEFAULT 0,
  `UserNumHours` int NOT NULL DEFAULT 0,
  `UserProgress` float NOT NULL DEFAULT 0,
  `SgStatus` varchar(255) NOT NULL DEFAULT "Planned",
  PRIMARY KEY (`SgUrl`, `UserName`, `DNum`, `LangCode`, `CourseID`),
  CONSTRAINT check_sgrole CHECK (`UserSgRole` IN ("Member", "Admin")),
  CONSTRAINT check_sgcontrib CHECK (`UserSgContrib` >= 0 AND `UserSgContrib` <= 10),
  CONSTRAINT check_sgrating CHECK (`UserSgRating` >= 0 AND `UserSgRating` <= 10),
  CONSTRAINT check_performance CHECK (`UserPerformance` >= 0 AND `UserPerformance` <= 100),
  CONSTRAINT check_progress CHECK (`UserProgress` >= 0 AND `UserProgress` <= 100),
  CONSTRAINT check_sgstatus CHECK (`SgStatus` IN ("Completed", "Active", "Planned"))
);

ALTER TABLE `KNOWS` ADD FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`);

ALTER TABLE `HAS_INTEREST_IN` ADD FOREIGN KEY (`SubName`) REFERENCES `SUBJECT` (`SubName`);

ALTER TABLE `COURSE` 
  ADD CONSTRAINT course_difficulty_fk
  FOREIGN KEY (`CourseName`, `CourseOrg`, `CoursePlatform`) REFERENCES `COURSE_DIFFICULTY` (`CourseName`, `CourseOrg`, `CoursePlatform`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `COURSE_INSTRUCTOR` ADD FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`);

ALTER TABLE `CONTAINS` 
  ADD CONSTRAINT contains_courseid_fk
  FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  ADD CONSTRAINT contains_subname_fk
  FOREIGN KEY (`SubName`) REFERENCES `SUBJECT` (`SubName`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `USED_FOR` 
  ADD CONSTRAINT used_for_langcode_fk
  FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `USED_FOR`
 ADD CONSTRAINT used_for_courseid_fk
 FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`)
 ON DELETE CASCADE
 ON UPDATE CASCADE;

ALTER TABLE `PREREQUISITE`
  ADD CONSTRAINT has_prereq_fk FOREIGN KEY (`HasPrerequisite`) REFERENCES `COURSE` (`CourseID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  ADD CONSTRAINT is_prereq_fk FOREIGN KEY (`PrerequisiteOf`) REFERENCES `COURSE` (`CourseID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `BLOGTAG` ADD FOREIGN KEY (`UserName`, `DNum`, `PostNumber`) REFERENCES `POST` (`UserName`, `DNum`, `PostNumber`);

ALTER TABLE `POST` 
  ADD CONSTRAINT post_courseid_fk
  FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `PINS`
  ADD CONSTRAINT pins_sgurl_fk
  FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `SG_EVENT`
  ADD CONSTRAINT event_sgurl_fk
  FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `MEET`
  ADD CONSTRAINT meet_has_upcoming_fk 
  FOREIGN KEY (`SgUrl`, `EventNum`) REFERENCES `SG_EVENT` (`SgUrl`, `EventNum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `TARGET`
  ADD CONSTRAINT target_has_upcoming_fk 
  FOREIGN KEY (`SgUrl`, `EventNum`) REFERENCES `SG_EVENT` (`SgUrl`, `EventNum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `PARTICIPATES_IN`
  ADD CONSTRAINT participates_sgurl_fk
  FOREIGN KEY (`SgUrl`) REFERENCES `STUDY_GROUP` (`SgUrl`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `PARTICIPATES_IN`
  ADD CONSTRAINT participates_langcode_fk
  FOREIGN KEY (`LangCode`) REFERENCES `LANGUAGE` (`LangCode`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `PARTICIPATES_IN`
  ADD CONSTRAINT participates_courseid_fk
  FOREIGN KEY (`CourseID`) REFERENCES `COURSE` (`CourseID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `KNOWS` ADD FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`);

ALTER TABLE `HAS_INTEREST_IN` ADD FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`);

ALTER TABLE `FRIENDS_WITH` ADD FOREIGN KEY (`Friend1Name`, `Friend1DNum`) REFERENCES `USER` (`UserName`, `DNum`);

ALTER TABLE `FRIENDS_WITH` ADD FOREIGN KEY (`Friend2Name`, `Friend2DNum`) REFERENCES `USER` (`UserName`, `DNum`);

ALTER TABLE `POST`
  ADD CONSTRAINT post_madeby_fk
  FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `PARTICIPATES_IN`
  ADD CONSTRAINT participates_user_fk
  FOREIGN KEY (`UserName`, `DNum`) REFERENCES `USER` (`UserName`, `DNum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

