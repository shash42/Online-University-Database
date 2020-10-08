import univutil
import os

class User:

    def __init__(self, sesh):
        self.logged_in = False #Why do we need these?!
        self.role = None
        self.sesh = sesh
        self.current_user = [None, None]
        return


    def show_friends_details(self):
        try:
            query = "SELECT Friend2Name,Friend2DNum from `FRIENDS_WITH` WHERE Friend1Name = '%s' AND Friend1DNum = '%s'"
            query = query % (self.current_user[0],self.current_user[1])
            self.sesh.cursor.execute(query)
            resultset1 = self.sesh.cursor.fetchall()
            query = "SELECT Friend1Name,Friend1DNum from `FRIENDS_WITH` WHERE Friend2Name = '%s' AND Friend2DNum = '%s'"
            query = query % (self.current_user[0],self.current_user[1])
            self.sesh.cursor.execute(query)
            resultset2 = self.sesh.cursor.fetchall()
            all_friends = resultset1 + resultset2
            check_str = "("
            n = len(all_friends)
            for friend in all_friends:
                var = list(friend.values())
                print(var)
                check_str += "("
                check_str += "'" + var[0] + "'"
                check_str += "," + str(var[1]) + ")" 
                n -= 1
                if(n != 0):
                    check_str += ","
            check_str += ")"
            subsetName = input("Enter part of friends full name: ")
            
            query = "SELECT CONCAT(FName,' ',MName,' ',SName) AS FULLNAME , Email FROM `USER` D WHERE "
            
            query += "(SELECT CONCAT(FName,' ',MName,' ',SName) FROM USER U WHERE U.UserName = D.UserName AND U.DNum = D.DNum)"
            
            query += " like '%" + subsetName + "%'" 
            query += " AND (D.UserName,D.DNum) in %s" % (check_str)
            
            
            self.sesh.cursor.execute(query)
            resultset = self.sesh.cursor.fetchall()
            if(not(resultset)):
                print("No matching result")
            else:
                number = 1
                for r in resultset:
                    print(number)
                    for e in r:
                        print(e,r[e],sep=":")
                    number += 1
        except Exception as e:
            print(e)
        
    def show_subject(self):
        query= 'SELECT * FROM SUBJECT'
        self.sesh.cursor.execute(query)
        resultset = self.sesh.cursor.fetchall()
        for r in resultset:
            print(r)
        return
 
    def showSgForCourse(self, courseid):
        self.sesh.cursor.execute("DROP VIEW IF EXISTS `REQ_SG`;")
        self.sesh.cursor.execute("CREATE VIEW `REQ_SG` AS (SELECT DISTINCT SgUrl FROM `PARTICIPATES_IN` WHERE CourseID = %s);", courseid); 
        self.sesh.cursor.execute("DROP VIEW IF EXISTS `POSS_SG`;")
        self.sesh.cursor.execute("CREATE VIEW `POSS_SG` AS (SELECT DISTINCT SgUrl FROM `REQ_SG` NATURAL JOIN `STUDY_GROUP` WHERE SgStatus = 'Active' OR SgStatus = 'Planned');")
        # sg_query = "SELECT SgUrl, AVG(UserSgRating), COUNT(EventNum), COUNT(DISTINCT (UserName, DNum)) \
        #             FROM  `POSS_SG` NATURAL JOIN `MEMBER_OF` NATURAL JOIN `SG_EVENT` \
        #             GROUP BY SgUrl \
        #             ORDER BY SgUpdated DESC;"

        sg_query = "SELECT MEMBER_OF.SgUrl, AVG(UserSgRating), COUNT(EventNum), COUNT(concat(UserName, DNum)) as Members \
                    FROM `POSS_SG` NATURAL JOIN `MEMBER_OF` LEFT JOIN `SG_EVENT` ON `MEMBER_OF`.SgUrl = `SG_EVENT`.SgUrl \
                    group by SgUrl;"
        self.sesh.cursor.execute(sg_query)
        result = self.sesh.cursor.fetchall()
        univutil.table_format(result)
        return result


    def manage_studygroup(self):
        query = "SELECT SgUrl FROM `PARTICIPATES_IN` WHERE UserName = %s and DNum = %s"
        self.sesh.cursor.execute(query, (self.current_user[0],self.current_user[1]))
        result = self.sesh.cursor.fetchall()
        univutil.table_format(result)
        sg_url = input("Enter URL of Study Group: ")
        if not(sg_url in [(lambda x : result[x]["SgUrl"])(i) for i in range(len(result))]):
            print("Invalid URL")
            input()
            return
        self.sesh.cursor.execute("SELECT UserSgRole FROM `MEMBER_OF` WHERE SgUrl = %s AND UserName = %s AND DNum = %s;",(sg_url, self.current_user[0], self.current_user[1]))
        result = self.sesh.cursor.fetchone()
        sg_role = result["UserSgRole"]
        if(sg_role == "Member"):
            return
        while(True):
            selection = 0
            print("1. Add pinned information")
            print("2. Add an event")
            print("3. Add options (course/languages)")
            print("5. Change status")
            print("6. Manage User")
            print("7. Exit")
            selection = input("Choose one of the above options: ")
            if(selection == "1"):
                self.create_pin(sg_url)
            elif(selection == "2"):
                self.create_event(sg_url)
            elif(selection == "3"):
                self.addoption_studygroup(sg_url)
            elif(selection == "5"):
                self.change_sgstatus(sg_url)
            elif(selection == "6"):
                print("Not implemented") #[TODO:]
            elif(selection == "7"):
                return
            else:
                print()
                return "Invalid choice. Please try again!"

        return

    def manage_connections(self):
        while(True):
            os.system("clear")
            print("1. Befriend")
            print("2. Search Friend Details by Name")
            print("5. Exit")
            choice = input("Enter choice number: ")
            if(choice == "1"):
                self.befriend()
            elif(choice == "2"):
                self.show_friends_details()
            elif(choice == "5"):
                break
            else:
                print("Invalid choice")
        return

    def manage_courses(self):
        while(True):
            os.system("clear")
            print("1. Enroll")
            print("2. Unenroll")
            print("3. Show offerings")
            print("4. Interests Update")
            print("5. Exit")
            choice = input("Enter choice number: ")
            if(choice == "1"):
                self.enroll()
            elif(choice == "2"):
                self.unenroll()
            elif(choice == "3"):
                self.show_offerings()
            elif(choice == "4"):
                self.update_interest()
            elif(choice == "5"):
                break
            else:
                print("Invalid choice")
        return

    def manage_posts(self):
        while(True):
            os.system("clear")
            print("1. Create Post")
            print("2. Edit Post")
            print("3. Delete Post")
            print("4. View Post of User")
            print("5. Exit")
            choice = input("Enter choice number: ")
            if(choice == "1"):
                self.make_post()
            elif(choice == "2"):
                self.update_post()
            elif(choice == "3"):
                self.delete_post()
            elif(choice == "4"):
                # [TODO:] Optionally implement
                print("Not implemented")
            elif(choice == "5"):
                break
            else:
                print("Invalid option")
        return


    def enroll(self): # This would be a insertion into the quarternary relationship along with creating study_group if reqd.
        try:
            print("You can enroll in a new course (and a study group) or a new study group for a course already being taken.")
            result = self.sesh.see_all("COURSE")
            courseid = int(input("CourseID: "))
            while(courseid not in [(lambda x: result[x]["CourseID"])(i) for i in range(len(result))]):
                courseid = int(input("CourseID: "))
            coursequery = "INSERT IGNORE INTO `TAKES` (UserName, DNum, CourseID) VALUES (%s, %s, %s);" 
            self.sesh.cursor.execute(coursequery, (self.current_user[0], self.current_user[1], courseid)) # This ignores if entry in TAKES already exists^
            print("Available study groups for this course:")
            values = self.showSgForCourse(courseid)
            new_sg = 'X'
            while(new_sg != 'N' and new_sg != 'E'):
                new_sg = input("Do you want to create your own study group (N) or join an existing one [E]: ")
            if(new_sg == "E"):
                sg = input("Study Group URL: ")
                while(sg not in [(lambda x: values[x]["SgUrl"])(i) for i in range(len(values))]):
                    sg = input("Enter valid study group URL: ")

            if(new_sg == 'N'):
                sg = input("Study Group URL: ")
                sgcreate = "INSERT INTO STUDY_GROUP (`SgUrl`) VALUES (%s);"
                self.sesh.cursor.execute(sgcreate, sg)
            sgquery = "INSERT IGNORE INTO `MEMBER_OF` (UserName, DNum, SgUrl, UserSgRole) VALUES (%s, %s, %s, %s);"
            self.sesh.cursor.execute(sgquery, (self.current_user[0], self.current_user[1], sg, "Admin"))
            print("Created a new study group succesfully!")
                
            
            #[TODO:] We are not showing languages of each study group, and user might not want any of those list, but is stuck in while() here.
            print("Available languages for this study group")
            langquery = "SELECT DISTINCT LangCode FROM PARTICIPATES_IN WHERE SgUrl = '%s'" % (sg)
            self.sesh.cursor.execute(langquery)
            result = self.sesh.cursor.fetchall()
            lfound = 0
            if(univutil.table_format(result) == 0):
                values = self.sesh.see_all("LANGUAGE")
                while(True):
                    choice = input("Pick language index: ")
                    try:
                        choice = int(choice)
                        langcode = values[choice-1]['LangCode']
                        lfound = 1
                        break
                    except:
                        print("Error. Invalid index")
            while(lfound==0):
                langcode = input("Language to participate in study_group (langcode): ")
                for i in range(self.sesh.cursor.rowcount):
                    if(result[i]["LangCode"]==langcode):
                        lfound=1
            
            query = "INSERT INTO PARTICIPATES_IN VALUES (%s, %s, %s, %s, %s);"
            self.sesh.cursor.execute(query, (self.current_user[0], self.current_user[1], sg, langcode, courseid))
            self.sesh.connection.commit()
            print("Enrolled in Course: %d as a member of Study Group: %s in language: %s succesfully!" % (courseid, sg, langcode))

        except Exception as e:
            print(e)
            ask_user_action(self.enroll)
        
        return

    def unenroll(self): # [TODO:] This would be a deletion from the quarternary relationship
        return    


    def addoption_studygroup(self, sg_url):
        print("Choose a Course and it's corresponding discussion language! Atleast one must be new for the study group")
        courseid = -1
        langcode = ""
        
        try:        
            #[TODO:] Validate if CourseID and Lang exist in DB or Display possible choices
            coursequery = "SELECT DISTINCT `CourseID` FROM `PARTICIPATES_IN` WHERE `SgUrl` = '%s'" % sg_url
            self.sesh.cursor.execute(coursequery)
            course_count = self.sesh.cursor.rowcount
            course_sg = self.sesh.cursor.fetchall()
            langquery = "SELECT DISTINCT `LangCode` FROM `PARTICIPATES_IN` WHERE `SgUrl` = '%s'" % sg_url
            self.sesh.cursor.execute(langquery)
            lang_count = self.sesh.cursor.rowcount
            lang_sg = self.sesh.cursor.fetchall()
            lang_new_flag = 1
            course_new_flag = 1

            while(langcode.__len__ != 3):
                langcode = input("Discussion Language [3-letter-code]: ")
            for i in range(lang_count):
                if(lang_sg[i]["LangCode"] == langcode):
                    lang_new_flag = 0
                    break
            
            while(courseid >= 0):
                courseid = int(input("CourseID: ")) 
            for i in range(course_count):
                if(course_sg[i]["CourseID"] == courseid):
                    course_new_flag = 0
                    break            

            if(course_new_flag == 0 and lang_new_flag == 0):
                print("You aren't inserting anything new!")
                return

            query = "INSERT INTO `PARTICIPATES_IN` VALUES (%s, %d, %s, %s, %d)" % (self.current_user[0], self.current_user[1], sg_url, langcode, courseid)
            self.sesh.cursor.execute(query)
            self.sesh.cursor.commit()
            if(course_new_flag):
                print("Added a new course succesfully!")
            if(lang_new_flag):
                print("Added a new language succesfully!")
                    
        except Exception as e:
            print(e)
            self.sesh.ask_user_action(self.addoption_studygroup)

        else: # Also add User - Course to User TAKES Course
            try:
                coursequery = "INSERT INTO `TAKES` (UserName, DNum, CourseID VALUES) VALUES (%s, %d, %d)" % (self.current_user[0], self.current_user[1], courseid)
                self.sesh.cursor.execute(coursequery)
                self.sesh.cursor.commit()
            except Exception as e:
                print(e) #[TODO:] After testing comment this and pass because error might be that it already exists

    def create_meet(self, sg_url, event_num):
        try:
            attrM = {
                "Meet Time YYYY/MM/DD HH/MI/SS" : "",
                "Meet Duration (mins)" : ""
            }
            for attribute in attrM:
                while(attrM[attribute]==""):
                    attrM[attribute] = input(attribute+": ")
                
            query = "INSERT INTO `MEET` (SgUrl, EventNum, MeetTime, MeetDuration) VALUES ('%s' '%s' '%s' '%s')" % (sg_url, event_num, attrM["Meet Time YYYY/MM/DD HH/MI/SS"], attrM["Meet Duration (mins)"])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            self.sesh.ask_user_action(self.create_meet)
        
        else:
            print("Added Event Succesfully!")
        return

    def create_target(self, sg_url, event_num):
        try:
            attrT = {
                "Deadline YYYY/MM/DD HH/MI/SS" : "",
            }
            for attribute in attrT:
                while(attrT[attribute]==""):
                    attrT[attribute] = input(attribute+": ")
                
            query = "INSERT INTO `TARGET` (TargetDeadline) VALUES ('%s', '%s', '%s')" % (sg_url, event_num, attrT["Deadline YYYY/MM/DD HH/MI/SS"])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()
            print("Added Event Succesfully!")

        except Exception as e:
            print(e)
            self.sesh.ask_user_action(self.create_target)
        
        return
    
    def create_event(self, sg_url):
        try:
            attrE = {
                "Event Number" : "", # [TODO:] This has to be computed using SgUrl
                "Event Title" : "",
                "Event Info." : ""
            }
            for attribute in attrE:
                    while(attrE[attribute]==""):
                        attrE[attribute] = input(attribute+": ")
            
            query = "INSERT INTO `SG_EVENT` (SgUrl, EventNum, EventTitle, EventInfo) VALUES ('%s' '%s' '%s' '%s')" % (sg_url, attrE["Event Number"], attrE["Event Title"], attrE["Event Info."])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.create_event)

        else:
            selection = 0
            while(selection!="1" and selection!="2"):
                print("Enter 1 for Meet and 2 for Target: ")
                selection = input()
            
            if(selection=="1"):
                self.create_meet(attrE["StudyGroup URL"], attrE["Event Number"])
            elif(selection=="2"):
                self.create_target(attrE["StudyGroup URL"], attrE["Event Number"])
    
        return
    
    def create_pin(self, sg_url):
        try:
            attrP = {
                "Pinned Info." : "",
            }
            for attribute in attrP:
                while(attrP[attribute]==""):
                    attrP[attribute] = input(attribute+": ")
            
            query = "INSERT INTO `PINS` (SgUrl, PinDetails) VALUES ('%s' '%s')" % (sg_url, attrP["Pinned Info."])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.create_pin)    
    
        return

    def change_sgstatus(self, sg_url):
        try:
            query = "SELECT 'SgStatus' from `STUDY_GROUP` WHERE 'SgUrl' = %s" % (sg_url)
            self.sesh.cursor.execute(query)
            result = self.sesh.cursor.fetchone()
            status = result[0]
            print("Current Status is: %s", status)
            while(True):
                status = input("Enter Status [Completed/Active/Planned]: ")
                if(status == "Completed" or status == "Active" or status == "Planned"):
                    break
                else:
                    print("Invalid input. Try again!")
            update = "UPDATE `STUDY_GROUP` SET `SgStatus` = %s WHERE `SgUrl` = %s" % (status, sg_url)
            self.sesh.cursor.execute(update)
            self.sesh.connection.commit()
        
        except Exception as e:
            print(e)
            univutil.ask_user_action(self.change_sgstatus)
        else:
            print("Status updated successfully!")

        return


    def make_post(self):
        try:
            query = "SELECT COUNT(*) FROM `POST` WHERE UserName=%s AND DNum = %s"
            self.sesh.cursor.execute(query, (self.current_user[0], self.current_user[1]))
            post_number = self.sesh.cursor.fetchone()["COUNT(*)"]

            attrP = {
                "Post Title" : "",
                "Post Content" : ""
            }
            for attribute in attrP:
                while(attrP[attribute]==""):
                    attrP[attribute] = input(attribute+": ")

            post_type = ""
            while(post_type!="Review" and post_type!="Blog"):
                post_type = input("Type [Review/Blog]: ")
            sql = "INSERT INTO `POST` "
            
            if(post_type == "Review"):
                attrR = {
                    "CourseID" : "",
                    "Rate course [1-10]" : ""
                }
                for attribute in attrR:
                    while(attrR[attribute]==""):
                        attrR[attribute] = input(attribute+": ")
                sql += "(`UserName`, `DNum`, `PostNumber`, `PostTitle`, `PostContent`, "
                sql += "`Type`, `CourseID`, `ReviewRating`) VALUES ( %s, %s, %s, %s, %s, %s, %s, %s );"
                self.sesh.cursor.execute(sql, (self.current_user[0], self.current_user[1], post_number, attrP["Post Title"],
                                    attrP["Post Content"], post_type, attrR["CourseID"], attrR["Rate course [1-10]"]))
            else:
                sql += "(`UserName`, `DNum`, `PostNumber`, `PostTitle`, `PostContent`, `Type`) VALUES ( %s, %s, %s, %s, %s, %s );"
                self.sesh.cursor.execute(sql, (self.current_user[0], self.current_user[1], post_number, attrP["Post Title"],
                                    attrP["Post Content"], post_type))
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.make_post)

        return
            
    
    def delete_post(self):
        try:
            query = "SELECT `PostNumber`, `PostTitle`, `PostContent` FROM `POST` WHERE `UserName` = '%s' AND `DNum` = %d" % (self.current_user[0], self.current_user[1])
            self.sesh.cursor.execute(query)
            result = self.sesh.cursor.fetchall()
            num_posts = self.sesh.cursor.rowcount
            if(num_posts == 0):
                print("Sorry, no posts exist to be deleted!")
                return
            print(num_posts, "posts currently exist!")
            
            univutil.table_format(result)
            post_num = num_posts
            while(post_num >= num_posts):
                post_num = int(input("Enter the post number to delete: "))
            
            print("Are you sure you want to delete the following post: ")
            print("Post Title: ", result[post_num]["PostTitle"])
            print("Post Content: ", result[post_num]["PostContent"])
            confirm = 'X'
            while(confirm != 'Y' and confirm != 'N'):
                confirm = input("I'm sure, delete [Y/N]: ")
            if(confirm == 'N'):
                return

            sql = "DELETE FROM `POST` "
            sql += "WHERE UserName = '%s' AND DNum = '%s' AND PostNumber = '%s'" % (self.current_user[0], self.current_user[1], post_num)
            print(sql)
            self.sesh.cursor.execute(sql)
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.delete_post)

        return


    def update_post(self):
        try:
            query = "SELECT `PostNumber`, `PostTitle`, `PostContent` FROM `POST` WHERE `UserName` = '%s' AND `DNum` = %d" % (self.current_user[0], self.current_user[1])
            self.sesh.cursor.execute(query)
            result = self.sesh.cursor.fetchall()
            num_posts = self.sesh.cursor.rowcount
            if(num_posts == 0):
                print("Sorry, no posts exist to be updated!")
                return
            print(num_posts, "posts currently exist!")
            
            post_num = num_posts
            univutil.table_format(result)
            while(post_num >= num_posts):
                post_num = int(input("Enter the post number: "))

            print("Post Title: ", result[post_num]["PostTitle"])
            print("Post Content: ", result[post_num]["PostContent"])
            print("Now, please enter your edited post details")

            attrP = {
                "Post Title" : "",
                "Post Content" : ""
            }
            for attribute in attrP:
                while(attrP[attribute]==""):
                    attrP[attribute] = input(attribute+": ")
            attrP["Post Title"] += " [edited]"

            update = "UPDATE `POST` SET `PostTitle` = %s, `PostContent` = %s WHERE `UserName` = %s AND `DNum` = '%s' AND `PostNumber` = '%s'"
            self.sesh.cursor.execute(update, (attrP["Post Title"], attrP["Post Content"], self.current_user[0], self.current_user[1], post_num))
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.update_post)
        
        return
    
    def show_offerings(self):
        os.system("clear")
        print("1. Courses")
        print("2. Subjects")
        choice = input()
        while(choice not in ["1", "2"]):
            choice = input()
        if(choice == "1"):
            self.sesh.see_available("COURSE")
        elif(choice == "2"):
            self.sesh.see_all("SUBJECT")
            input()

    def befriend(self):
        try:
            attributes = {
                "Friend2Name" : "",
                "Friend2DNum" : ""
            }
            for attribute in attributes:
                while(attributes[attribute]==""):
                    if(attribute == 'Friend2DNum'):
                        attributes[attribute] = int(input(attribute+": "))
                    else:
                        attributes[attribute] = input(attribute+": ")
                        
                        
            
            query = "INSERT INTO `FRIENDS_WITH` (Friend1Name,Friend1DNum,Friend2Name,Friend2DNum) VALUES ('%s',%d,'%s',%d)" % (attributes["Friend2Name"],attributes["Friend2DNum"],self.current_user[0],self.current_user[1])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()
        
        except Exception as e:    
            print(e)
            univutil.ask_user_action(self.befriend)

        return

    def update_interest(self):
        try:
            SubName = ""
            while(SubName == ""):
                SubName = input("Subject Name: ")
            InterestType = ""
            while(InterestType == ""):
                InterestType = input('Modified Interest Type["Research" ,"Professional" , "Major" ,"Minor" ,"Casual"]: ')
                if InterestType not in ["Research" ,"Professional" , "Major" ,"Minor" ,"Casual"]:
                    InterestType = ""
            query = "UPDATE `HAS_INTEREST_IN` SET InterestType = '%s' WHERE UserName = '%s' and DNum = %d and SubName = '%s'" %(InterestType,self.current_user[0],self.current_user[1],SubName)
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()

        except Exception as e:    
            print(e)
            univutil.ask_user_action(self.update_interest)

        return
