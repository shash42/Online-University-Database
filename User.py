import univutil

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

    
    def enroll(self): # This would be a insertion into the quarternary relationship along with a call to create_studygroup if reqd.
        return


    def unenroll(self): # This would be a deletion from the quarternary relationship
        return

    def manage_studygroup(self):
        # [TODO:] Display list of study groups user is part of here.
        sg_url = input("Enter URL of Study Group: ")
        # [TODO:] Check if the study group exists
        # [TODO:] If user does not have manage access, return
        while(True):
            selection = 0
            print("1. Add pinned information")
            print("2. Add an event")
            print("3. Add a course")
            print("4. Add a language")
            print("5. Change status")
            print("9. Exit")
            selection = print("Choose one of the above options: ")
            if(selection == "1"):
                self.create_pin(sg_url)
            elif(selection == "2"):
                self.create_event(sg_url)
            elif(selection == "3"):
                print("Not implemented") # [TODO]
            elif(selection == "4"):
                print("Not implemented") # [TODO]
            elif(selection == "5"):
                self.change_sgstatus(sg_url)
            elif(selection == "9"):
                return
            else:
                print("Invalid choice. Please try again!")

        return
    
    def create_studygroup(self):
        try:
            attributes = {
                "StudyGroup URL" : "",
            }
            for attribute in attributes:
                    while(attributes[attribute]==""):
                        attributes[attribute] = input(attribute+": ")
                                  
            query = "INSERT INTO `STUDY_GROUP` (SgUrl) VALUES ('%s')" % (attributes["SgUrl"])
            self.sesh.cursor.execute(query)
            self.sesh.connection.commit()
        
        except Exception as e:
            print(e)
            self.sesh.ask_user_action(self.create_studygroup)
    
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
            print("Added Event Succesfully!")

        except Exception as e:
            print(e)
            self.sesh.ask_user_action(self.create_meet)
        
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
            attrP = {
                "Post Number" : "", # [TODO:] Generate post_number based on no. of posts made by the username+dnum
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
                self.sesh.cursor.execute(sql, (self.current_user[0], self.current_user[1], attrP["Post Number"], attrP["Post Title"],
                                    attrP["Post Content"], post_type, attrR["CourseID"], attrR["Rate course [1-10]"]))
            else:
                sql += "(`UserName`, `DNum`, `PostNumber`, `PostTitle`, `PostContent`, `Type`) VALUES ( %s, %s, %s, %s, %s, %s );"
                self.sesh.cursor.execute(sql, (self.current_user[0], self.current_user[1], attrP["Post Number"], attrP["Post Title"],
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
            
            post_num = num_posts
            while(post_num >= num_posts):
                post_num = int(input("Enter the post number to delete (0-indexed): "))
            
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
            print(result)
            if(num_posts == 0):
                print("Sorry, no posts exist to be updated!")
                return
            print(num_posts, "posts currently exist!")
            
            post_num = num_posts
            while(post_num >= num_posts):
                post_num = int(input("Enter the post number (0-indexed): "))

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
