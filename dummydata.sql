USE `UNIVERSITY`;
INSERT INTO `USER` VALUES ("loremipsum",0,"SHASWAT",NULL,"GOEL","2001-01-01","abc@gmail.com","1234");
INSERT INTO `USER` VALUES ("morningstar",0,"ADITYA",NULL,"HARI","2000-01-01","abc@yahoo.com","12345");
INSERT INTO `USER` VALUES ("lifeisgreat",0,"PRINCE",NULL,"VARSHNEY","2000-08-05","abc123@gmail.com","123456");

INSERT INTO `LANGUAGE` VALUES ("eng","ENGLISH");
INSERT INTO `LANGUAGE` VALUES ("fre","FRENCH");
INSERT INTO `LANGUAGE` VALUES ("ger","GERMAN");

INSERT INTO `SUBJECT` VALUES ("Computer Science");
INSERT INTO `SUBJECT` VALUES ("Mathematics");
INSERT INTO `SUBJECT` VALUES ("Humanities");

INSERT INTO `KNOWS` VALUES ("loremipsum",0,"eng","Professional Working");
INSERT INTO `KNOWS` VALUES ("morningstar",0,"eng","Professional Working");
INSERT INTO `KNOWS` VALUES ("lifeisgreat",0,"eng","Professional Working");
INSERT INTO `KNOWS` VALUES ("morningstar",0,"fre","Elementary");
INSERT INTO `KNOWS` VALUES ("lifeisgreat",0,"ger","Elementary");

INSERT INTO `HAS_INTEREST_IN` VALUES ("loremipsum",0,"Computer Science","Research");
INSERT INTO `HAS_INTEREST_IN` VALUES ("morningstar",0,"Humanities","Major");
INSERT INTO `HAS_INTEREST_IN` VALUES ("lifeisgreat",0,"Mathematics","Major");

INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("loremipsum",0,"morningstar",0);
INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ("morningstar",0,"lifeisgreat",0);

INSERT INTO `COURSE_DIFFICULTY` VALUES
("LINEAR ALGEBRA","MIT-OCW","Expert","YOUTUBE"),
("CULTURE","NPTEL","Beginner","Swayam"),
("OPEARTING SYSTEM","COURSERA","Intermediate","COURSERA"),
("MACHINE LEARNING","EDX","Expert","EDX");



INSERT INTO `COURSE` (`CourseName`, `CourseOrg`, `CoursePlatform`, `CourseHours`, `CourseDuration`) VALUES
("LINEAR ALGEBRA","MIT-OCW","YOUTUBE",10,30),
("CULTURE","NPTEL","Swayam",8,25),
("OPEARTING SYSTEM","COURSERA","COURSERA",15,45),
("MACHINE LEARNING","EDX","EDX",20,52);



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







