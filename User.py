import univutil

class User:

    def __init__(self, sesh):
        self.logged_in = False #Why do we need these?!
        self.role = None
        self.sesh = sesh
        return

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
            print("5. Exit")
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

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.create_pin)    
    
        return


    def make_post(self):
        try:
            attrP = {
                "Post Number" : "", # [TODO:] Generate post_number based on no. of posts made by the username+dnum
                "Post Title" : "",
                "Post content" : ""
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
                                    attrP["Post Content"], attrP["Post Type"], attrR["CourseID"], attrR["Rate course [1-10]"]))
            else:
                sql += "(`UserName`, `DNum`, `PostNumber`, `PostTitle`, `PostContent`, `Type`) VALUES ( %s, %s, %s, %s, %s, %s );"
                self.sesh.cursor.execute(sql, (self.current_user[0], self.current_user[1], attrP["Post Number"], attrP["Post Title"],
                                    attrP["Post Content"], attrP["Post Type"]))
            self.sesh.connection.commit()

        except Exception as e:
            print(e)
            univutil.ask_user_action(self.make_post)

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
