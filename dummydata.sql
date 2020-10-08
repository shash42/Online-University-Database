USE `UNIVERSITY`;
INSERT INTO `USER` VALUES ("user1",0,"SHASWAT",NULL,"GOEL","2001-01-01","abc@gmail.com","1");
INSERT INTO `USER` VALUES ("user2",0,"ADITYA",NULL,"HARI","2000-01-01","abc@yahoo.com","2");
INSERT INTO `USER` VALUES ("user3",0,"PRINCE",NULL,"VARSHNEY","2000-08-05","abc123@gmail.com","3");
INSERT INTO `USER` VALUES ("user4",0,"Tom",NULL,"Riddle","2000-08-05","test@gmail.com","4");
INSERT INTO `USER` VALUES ("user5",0,"Harry",NULL,"Potter","2000-08-05","test1@gmail.com","5");
INSERT INTO `USER` VALUES ("user6",0,"Danny","de","Vito","2000-08-05","test2@gmail.com","6");
INSERT INTO `USER` VALUES ("user7",0,"Katniss",NULL,"Everdeen","2000-08-05","test3@gmail.com","7");

INSERT INTO `LANGUAGE` VALUES ("eng","ENGLISH");
INSERT INTO `LANGUAGE` VALUES ("fre","FRENCH");
INSERT INTO `LANGUAGE` VALUES ("ger","GERMAN");

INSERT INTO `SUBJECT` VALUES ("Computer Science");
INSERT INTO `SUBJECT` VALUES ("Mathematics");
INSERT INTO `SUBJECT` VALUES ("Humanities");

INSERT INTO `KNOWS` VALUES ("user1",0,"eng","Professional Working");
INSERT INTO `KNOWS` VALUES ("user1",0,"ger","Elementary");
INSERT INTO `KNOWS` VALUES ("user2",0,"eng","Native");
INSERT INTO `KNOWS` VALUES ("user3",0,"eng","Professional Working");
INSERT INTO `KNOWS` VALUES ("user3",0,"fre","Native");
INSERT INTO `KNOWS` VALUES ("user4",0,"fre","Native");
INSERT INTO `KNOWS` VALUES ("user4",0,"eng","Native");
INSERT INTO `KNOWS` VALUES ("user5",0,"eng","Native");
INSERT INTO `KNOWS` VALUES ("user6",0,"eng","Elementary");
INSERT INTO `KNOWS` VALUES ("user7",0,"fre","Elementary");

INSERT INTO `HAS_INTEREST_IN` VALUES ("user1",0,"Computer Science","Research");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user1",0,"Mathematics","Minor");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user2",0,"Humanities","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user2",0,"Mathematics","Casual");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user3",0,"Mathematics","Minor");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user3",0,"Computer Science","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user4",0,"Computer Science","Research");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user4",0,"Humanities","Casual");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user5",0,"Mathematics","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user5",0,"Humanities","Casual");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user6",0,"Mathematics","Minor");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user6",0,"Computer Science","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user7",0,"Mathematics","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("user7",0,"Humanities","Major");

INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user1",0,"user2",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user1",0,"user4",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user2",0,"user3",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user4",0,"user5",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user6",0,"user3",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user2",0,"user7",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("user1",0,"user7",0);

INSERT INTO `COURSE_DIFFICULTY` VALUES
("LINEAR ALGEBRA","MIT-OCW","Expert","YOUTUBE"),
("CULTURE","NPTEL","Beginner","Swayam"),
("OPERATING SYSTEM","COURSERA","Intermediate","COURSERA"),
("MACHINE LEARNING","EDX","Expert","EDX");

INSERT INTO `COURSE` (`CourseName`, `CourseOrg`, `CoursePlatform`, `CourseHours`, `CourseDuration`) VALUES
("LINEAR ALGEBRA","MIT-OCW","YOUTUBE",8,8),
("CULTURE","NPTEL","Swayam",6,10),
("OPERATING SYSTEM","COURSERA","COURSERA",10,10),
("MACHINE LEARNING","EDX","EDX",12,6);

INSERT INTO `COURSE_INSTRUCTOR` VALUES
("XYZ",1),
("PQR",1),
("MNO",2),
("ABC",3),
("LMN",4);

INSERT INTO `CONTAINS` VALUES
("Mathematics",1),
("Computer Science",1),
("Humanities",2),
("Computer Science",3),
("Computer Science",4);

INSERT INTO `USED_FOR` VALUES
("eng",1,"Native"),
("eng",2,"Native"),
("eng",3,"Native"),
("eng",4,"Native"),
("fre",2,"Sub"),
("ger",3,"Dub");

INSERT INTO `PREREQUISITE` VALUES
(4,1,"Essential");







