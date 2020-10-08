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
            dnum = self.sesh.get_number(username,"USER","UserName")
            fname = input("First Name*: ")
            mname = input("Middle Name: ")
            if(mname == ""):
                mname = None
            lname = input("Last Name*: ")
            dob = input("Date of Birth (YYYY-MM-DD))*: ")
            email = input("Email*: ")
            password = input("Password*: ")
            sql = "INSERT INTO `USER` values (%s, %s, %s, %s, %s, %s, %s, %s);"
            self.sesh.cursor.execute(sql, (username,dnum,fname,mname,lname,dob,email,password))

            values = self.sesh.see_all("LANGUAGE")
            numberOfLanguagesKnown = 0
            while(numberOfLanguagesKnown <= 0):
                numberOfLanguagesKnown = int(input("Enter Number of languages known[atleast one]: "))
            for _ in range(numberOfLanguagesKnown):
                self.add_languageKnown(username,dnum, values)

            values = self.sesh.see_all("SUBJECT")
            numberOfSubjectInterest = 0
            while numberOfSubjectInterest <= 0:
                numberOfSubjectInterest = int(input("Enter Number of Subject Interest[atleast one]: "))
            for _ in range(numberOfSubjectInterest):
                self.add_subjectInterest(username,dnum, values)
            self.sesh.connection.commit()
            print(f'Registered succesfully! Username: {username} DNum: {dnum}')
            input()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.add_user)

        return "Added user"


    def get_number(self, username,tablename,columnname):
        query = "SELECT COUNT(*) FROM `%s` WHERE %s='%s'"%(tablename,columnname,username)
        #print(query)
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
                subdub = ""
                values = self.sesh.see_all("LANGUAGE")
                choice = input("Pick language index: ")
                while(True):
                    try:
                        choice = int(choice)
                        lang = values[choice-1]['LangCode']
                        break
                    except:
                        print("Error. Invalid index")
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
                values = self.sesh.see_all("SUBJECT")
                choice = input("Pick subject index: ")
                while(True):
                    try:
                        choice = int(choice)
                        subject = values[choice-1]['SubName']
                        break
                    except:
                        print("Error. Invalid index")
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
                sql_query = f'SELECT CourseID, CourseName FROM `COURSE`;'
                self.sesh.cursor.execute(sql_query)
                result = self.sesh.cursor.fetchall()
                table_format(result)
                choice = input("Select course index: ")
                while(True):
                    try:
                        choice = int(choice)
                        courseprerequisite = values[choice-1]['CourseID']
                        break
                    except:
                        print("Error. Invalid index")
                courseprerequisite_importance = ""
                while(courseprerequisite_importance not in ["Helpful", "Essential"]):
                    courseprerequisite_importance = input("Prequisite importance [Helpful/Essential]: ")
                sql_instructor = "INSERT INTO `PREREQUISITE` values (%s, %s, %s)"
                self.sesh.cursor.execute(sql_instructor, (courseid, courseprerequisite, courseprerequisite_importance))
                if(input("More preqrequisites? [y/n]: ") == "n"):
                    break
            
            self.sesh.connection.commit()
        except Exception as e:
            #print(e)
            univutil.ask_user_action(self.add_course)

    def delete_course(self):
        try:
            values = self.sesh.see_all("COURSE")
            choice = input("Enter course index: ")
            choice = int(choice)
            cname, corg, cplat = values[choice-1]['CourseName'], values[choice-1]['CourseOrg'], values[choice-1]['CoursePlatform']
            sure = input("Are you sure? [y/n]: ")
            if(sure == "n"):
                return "Course not deleted"
            sql_query = "DELETE FROM `COURSE_DIFFICULTY` WHERE CourseName = %s AND CourseOrg = %s AND CoursePlatform = %s"
            self.sesh.cursor.execute(sql_query, (cname, corg, cplat))
            self.sesh.connection.commit()
        except:
            univutil.ask_user_action(self.delete_course)

    def add_subject(self):
        try:
            print('ADDING SUBJECT')
            
            attributes = {"Subject Name: ":""
                }
        
            for attribute in attributes:
                while(attributes[attribute]==""):
                    attributes[attribute] = input(attribute)
                
            query = "INSERT INTO `SUBJECT` VALUES ('%s');" % (attributes["Subject Name: "]) 
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()
            return "Added subject"
        except Exception as e:
            ##print(e)
            univutil.ask_user_action(self.add_subject)


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
            return "Added subject"
        except Exception as e:
            #print(e)
            univutil.ask_user_action(self.add_language)

    # [TODO:] CHECK THESE TWO LMAO
    def add_subjectInterest(self,username,dnum, values):
        SubName = ""
        choice = input("Pick subject index: ")
        while(True):
            try:
                choice = int(choice)
                SubName = values[choice-1]['SubName']
                break
            except:
                print("Error. Invalid index")
        InterestType = ""
        while(InterestType == ""):
            InterestType = input('Interest Type ["1. Research" ,"2. Professional" , "3. Major" ,"4. Minor" ,"5. Casual"]: ')
            if InterestType not in ["1","2","3","4","5"]:
                InterestType = ""
            InterestType = ["Research" ,"Professional" , "Major" ,"Minor" ,"Casual"][int(InterestType)-1]
        query = "INSERT INTO `HAS_INTEREST_IN` VALUES ('%s',%d,'%s','%s')" %(username,dnum,SubName,InterestType)
        self.sesh.cursor.execute(query)
            
        # except Exception as e:
        #     #print(e)
        #     print("Try again")
        #     self.add_subjectInterest(username, dnum)

    def add_languageKnown(self,username,dnum, values):
        choice = input("Pick language index: ")
        while(True):
            try:
                choice = int(choice)
                LangCode = values[choice-1]['LangCode']
                break
            except:
                print("Error. Invalid index")
        Fluency = ""
        while(Fluency == ""):
            Fluency = input('Fluency["1. Elementary" ,"2. Limited Working" , "3. Professional Working" ,"4. Native"]: ')
            if Fluency not in ["1", "2", "3", "4"]:
                Fluency = ""
            Fluency = ["Elementary" ,"Limited Working" , "Professional Working" ,"Native"][int(Fluency)-1]
        query = "INSERT INTO `KNOWS` VALUES ('%s',%d,'%s','%s')" %(username,dnum,LangCode,Fluency)
        print(query)
        self.sesh.cursor.execute(query)
            
        # except Exception as e:
        #     #print(e)
        #     print("Try again")
        #     self.add_languageKnown(username, dnum)

        return

    def avg_events(self):
        sgquery = "SELECT SgUrl FROM STUDY_GROUP"
        self.sesh.cursor.execute(sgquery)
        num_sg = self.sesh.cursor.rowcount
        eventquery = "SELECT SgUrl, EventNum from SG_EVENT"
        self.sesh.cursor.execute(eventquery)
        num_event = self.sesh.cursor.rowcount
        print("Average Number of Events is: ", num_event/num_sg)
        return
    
    def stat1(self):
        sql_users = "SELECT UserName, DNum FROM USER"
        self.sesh.cursor.execute(sql_users)
        result = self.sesh.cursor.fetchall()
        if(univutil.table_format(result) == 0):
            print("No users")
            input()
            return
        choice = input("Select index number: ")
        while(True):
            try:
                username, dnum = result[int(choice)-1]["UserName"], result[int(choice)-1]["DNum"]
                break
            except:
                print("Invalid index")
                input()
                return
        self.sesh.cursor.execute("DROP VIEW IF EXISTS FRIENDS;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS SUBS;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS FRIENDS_SUBS;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS COMMON_INTS;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS COMMON_SGS;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS SgUrls;")
        self.sesh.cursor.execute("DROP VIEW IF EXISTS FRIENDS_SG;")

        self.sesh.cursor.execute("CREATE VIEW FRIENDS AS (SELECT Friend2Name, Friend2DNum FROM FRIENDS_WITH WHERE Friend1Name = %s AND Friend2DNum = %s);", (username, dnum))
        self.sesh.cursor.execute("CREATE VIEW SUBS AS (SELECT UserName, DNum, SubName FROM HAS_INTEREST_IN WHERE UserName = %s AND DNum = %s);", (username, dnum))
        self.sesh.cursor.execute("CREATE VIEW SgUrls AS (SELECT UserName, DNum, SgUrl FROM PARTICIPATES_IN WHERE UserName = %s AND DNum = %s);", (username, dnum))
        self.sesh.cursor.execute("CREATE VIEW FRIENDS_SUBS AS (SELECT UserName, DNum, SubName from HAS_INTEREST_IN JOIN FRIENDS ON UserName = Friend2Name and DNum = Friend2DNum);")
        self.sesh.cursor.execute("CREATE VIEW FRIENDS_SG AS (SELECT UserName, DNum, SgUrl from PARTICIPATES_IN JOIN FRIENDS ON UserName = Friend2Name and DNum = Friend2DNum);")
        self.sesh.cursor.execute("CREATE VIEW COMMON_INTS AS (SELECT UserName, DNum, Count(*) as CommonInterests FROM FRIENDS_SUBS WHERE SubName in (SELECT SubName FROM FRIENDS_SUBS) GROUP BY UserName, DNum);")
        self.sesh.cursor.execute("CREATE VIEW COMMON_SGS AS (SELECT UserName, DNum, Count(*) as CommonStudyGroups FROM FRIENDS_SUBS WHERE SubName in (SELECT SubName FROM FRIENDS_SUBS) GROUP BY UserName, DNum);")
        self.sesh.cursor.execute("SELECT COMMON_INTS.UserName, COMMON_INTS.DNum, CommonInterests, CommonStudyGroups from COMMON_INTS JOIN COMMON_SGS ON COMMON_INTS.UserName = COMMON_SGS.UserName and COMMON_INTS.DNum = COMMON_SGS.DNum;")
        result = self.sesh.cursor.fetchall()
        if(univutil.table_format(result) == 0):
            print("Nothing found.")
        input()
