import os
import univutil

class Admin:
    def __init__(self, sesh):
        self.sesh = sesh
        return

    def add_user(self):
        try:
            os.system('clear')
            print("ADD NEW USER")
            username = input("Username*: ")
            dnum = self.get_number(username,"USER","UserName")
            fname = input("First Name*: ")
            mname = input("Middle Name: ")
            if(mname == ""):
                mname = None
            lname = input("Last Name*: ")
            dob = input("Date of Birth (YYYY-MM-DD))*: ")
            email = input("Email*: ")
            password = input("Password*: ")
            sql = "INSERT INTO `USER` values ('%s',%d, '%s', '%s', '%s', '%s', '%s','%s');" % (username,dnum,fname,mname,lname,dob,email,password)
            self.sesh.cursor.execute(sql)
            
            numberOfLanguagesKnown = 0
            while(numberOfLanguagesKnown <= 0):
                numberOfLanguagesKnown = int(input("Enter Number of languages known[atleast one]: "))
            for _ in range(numberOfLanguagesKnown):
                self.add_languageKnown(username,dnum)
            numberOfSubjectInterest = 0
            while numberOfSubjectInterest <= 0:
                numberOfSubjectInterest = int(input("Enter Number of Subject Interest[atleast one]: "))
            for _ in range(numberOfSubjectInterest):
                self.add_subjectInterest(username,dnum)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.add_user)
        return


    def get_number(self, username,tablename,columnname):
        query = "SELECT COUNT(*) FROM `%s` WHERE %s='%s'"%(tablename,columnname,username)
        self.sesh.cursor.execute(query)
        resultset = self.sesh.cursor.fetchone()
        
        return resultset['COUNT(*)']


    def add_course(self):
        try:
            os.system("clear")
            print("ADD NEW COURSE")
            attributes = {"Course Name: ":"", 
                        "Course Org: ":"", 
                        "Course Platform: ":"",
                        "Weekly Course Hours: ":"",
                        "Course Duration: ":""
                    }
            courseid_sql = "SELECT LAST_INSERT_ID();"
            
            coursedifficulty = ""
            for attribute in attributes:
                while(attributes[attribute]==""):
                    attributes[attribute] = input(attribute)
            while(True):
                coursedifficulty = input("Course Difficulty [1. Beginner/2. Intermediate/3. Expert]: ")
                if(coursedifficulty in ["1", "2", "3"]):
                    coursedifficulty = ["Beginner", "Intermediate", "Expert"][int(coursedifficulty)-1]
                    break
            sql_difficulty = "INSERT INTO `COURSE_DIFFICULTY` (`CourseName`, `CourseOrg`, `CoursePlatform`, `CourseDifficulty`) values (%s, %s, %s, %s);"
            sql_course = "INSERT INTO `COURSE` (`CourseName`, `CourseOrg`, `CoursePlatform`, `CourseHours`, `CourseDuration`) values (%s, %s, %s, %s, %s);"

            self.sesh.cursor.execute(sql_difficulty, tuple(attributes.values())[:3]+(coursedifficulty,))
            self.sesh.cursor.execute(sql_course, tuple(attributes.values()))
            self.sesh.cursor.execute(courseid_sql)
            courseid = self.sesh.cursor.fetchone()['LAST_INSERT_ID()']

            while(True):
                lang = ""
                subdub = ""
                while(lang==""):
                    lang = input("Course Language: ")
                while(subdub not in ["Native","Sub","Dub"]):
                    subdub = input("Language support [Native/Sub/Dub]: ")
                if(subdub == "Native"):
                    subdub = None
                sql_lang = "INSERT INTO `USED_FOR` values (%s, %s, %s)"
                self.sesh.cursor.execute(sql_lang, (lang, courseid, subdub))
                cont = input("More languages? [y/n]: ")
                if(cont == "n"):
                    break
            
            while(True):
                subject = ""
                while(subject == ""):
                    subject = input("Select the subject the course belongs to: ")
                sql_sub = "INSERT INTO `CONTAINS` values(%s, %s)"
                self.sesh.cursor.execute(sql_sub, (subject, courseid))
                cont = input("More subjects? [y/n]: ")
                if(cont == "n"):
                    break

            instructor = input("Add course instructor? [y/n]: ")
            while(instructor == "y"):
                courseinstructor = ""
                while(courseinstructor == ""):
                    courseinstructor = input("Instructor Name: ")
                sql_instructor = "INSERT INTO `COURSE_INSTRUCTOR` values (%s, %s)"
                self.sesh.cursor.execute(sql_instructor, (courseinstructor, courseid))
                if(input("More instructors? [y/n]: ") == "n"):
                    break
            
            prereq = input("Add course prerequisites? [y/n]: ")
            while(prereq == "y"):
                courseprerequisite = "" 
                courseprerequisite_importance = ""
                while(courseprerequisite==""):
                    courseprerequisite = input("Prequisite course ID: ")
                while(courseprerequisite_importance not in ["Helpful", "Essential"]):
                    courseprerequisite_importance = input("Prequisite importance [Helpful/Essential]: ")
                sql_instructor = "INSERT INTO `PREREQUISITE` values (%s, %s, %s)"
                self.sesh.cursor.execute(sql_instructor, (courseid, courseprerequisite, courseprerequisite_importance))
                if(input("More preqrequisites? [y/n]: ") == "n"):
                    break
            
            self.sesh.connection.commit()
            return "Course added"

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.add_course)

    def delete_course(self):
        # try:
        courseid = input("Enter CourseID: ")
        sql_query = "SELECT * FROM `COURSE` WHERE CourseID = %s"
        self.sesh.cursor.execute(sql_query, courseid)
        result = self.cursor.fetchone()
        print(result)
        if(len(result) != 1):
            return "Course with selected ID not present"
        print(result)
        sure = input("Are you sure? [y/n]: ")
        if(sure == "n"):
            return "Course not deleted"
        sql_query = "DELETE FROM `COURSE` WHERE CourseID = %s"
        self.sesh.cursor.execute(sql_query, courseid)
        self.sesh.connection.commit()
        return "Course deleted"
        # except:
        #     univutil.ask_user_action(self.delete_course)

    def add_subject(self):
        #try:
        print('ADDING SUBJECT')
        
        attributes = {"Subject Name: ":""
            }
    
        for attribute in attributes:
            while(attributes[attribute]==""):
                attributes[attribute] = input(attribute)
            
        query = "INSERT INTO `SUBJECT` VALUES ('%s');" % (attributes["Subject Name: "]) 
        self.sesh.cursor.execute(query)
        self.sesh.connection.commit()
        # except Exception as e:
        #     print(e)
        #     self.ask_user_action(self.add_subject)


    def add_language(self):
        try:
            print("ADDING LANGUAGE")
            attributes = {
                'LangCode' : "",
                'LangName' : ""
            }
            
            for attribute in attributes:
                while(attributes[attribute]==""):
                    attributes[attribute] = input(attribute+": ")
                    if attribute == 'LangCode':
                        while(len(attributes[attribute]) != 3):
                            print("LangCode should be of 3 characters")
                            attributes[attribute] = input(attribute+": ")
            
            query = "INSERT INTO `LANGUAGE` VALUES ('%s','%s')" % (attributes['LangCode'],attributes['LangName'])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.add_language)
    
    def add_prerequisite(self):
        return

    # [TODO:] CHECK THESE TWO LMAO
    def add_subjectInterest(self,username,dnum):
        try:
            SubName = ""
            while(SubName == ""):
                SubName = input("Subject Name: ")
            InterestType = ""
            while(InterestType == ""):
                InterestType = input('Interest Type["Research" ,"Professional" , "Major" ,"Minor" ,"Casual"]: ')
                if InterestType not in ["Research" ,"Professional" , "Major" ,"Minor" ,"Casual"]:
                    InterestType = ""
            query = "INSERT INTO `HAS_INTEREST_IN` VALUES ('%s',%d,'%s','%s')" %(username,dnum,SubName,InterestType)
            self.sesh.cursor.execute(query)
            
        except Exception as e:
            print(e)
            print("Try again")
            self.add_languageKnown(username, dnum)

    def add_languageKnown(self,username,dnum):
        try:
            LangCode = ""
            while(LangCode == ""):
                LangCode = input("Language Code[3 characters]: ")
                if(len(LangCode) != 3):
                    LangCode = ""
            Fluency = ""
            while(Fluency == ""):
                Fluency = input('Fluency["Elementary" ,"Limited Working" , "Professional Working" ,"Native"]: ')
                if Fluency not in ["Elementary" ,"Limited Working" , "Professional Working" ,"Native"]:
                    Fluency = ""
            query = "INSERT INTO `KNOWS` VALUES ('%s',%d,'%s','%s')" %(username,dnum,LangCode,Fluency)
            print(query)
            self.sesh.cursor.execute(query)
            
        except Exception as e:
            print(e)
            print("Try again")
            self.add_languageKnown(username, dnum)

        return