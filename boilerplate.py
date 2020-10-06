from datetime import datetime
import os
import pymysql.cursors
from User import User
from Admin import Admin
from univutil import table_format

class Session:
    
    def __init__(self):
        # self.connection = pymysql.connect(host="localhost",
        #                       user="daa",
        #                       password="",
        #                       db='UNIVERSITY',
        #                       charset='utf8mb4',
        #                       cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.connection.cursor()
        self.user = User(self)
        self.admin = Admin(self)

    def login_screen(self):
        while True:
            os.system("clear")
            print("Hello!")
            print("1. Login")
            print("2. Sign Up")
            print("3. Exit")

            selection = input()
            if(selection == "1"):
                self.login()
            elif(selection == "2"):
                self.signup()
            elif(selection == "3"):
                break
            else:
                print("Invalid option")

    def login(self):
        os.system("clear")
#        try:
        UName = input('UserName: ')
        DNumber = int(input('DNumber: '))
        Pass = input('Password: ')
        query = "SELECT Password from `USER` where UserName = '%s' AND DNum = %d" % (UName,DNumber)
        self.cursor.execute(query)
        resultset = self.cursor.fetchone()
        if(not(resultset)):
            print("You need to sign up first")
            input()
        else:
            if(resultset['Password'] == Pass):
                print("Sucessfully logged in")
                input()
                self.user.current_user = [UName,DNumber]
                self.user_screen()
            else:
                print("Authentication failed")
                input()
        # except Exception as e:
        #     print(e)
    
    def signup(self):
        self.admin.add_user()
    
    def user_screen(self):
        while True:
            os.system("clear")
            print("1. Befriend")
            print("2. Manage Study Group")
            print("3. Interests Update")
            print("4. Show offerings")
            print("5. Create Post")
            print("6. Delete Post")
            print("7. Edit Post")
            print("8. Search friend details by name")
            print("9. EXIT")
            choice = input()
            if(choice == "1"):
                self.user.befriend()
            elif(choice == "2"):
                self.user.manage_studygroup()
            elif(choice == "3"):
                self.user.update_interest()
            elif(choice == '4'):
                os.system("clear")
                print("1. Courses")
                print("2. Subjects")
                choice = input()
                self.see_available("COURSE")
            elif(choice == "5"):
                self.user.make_post()
            elif(choice == "6"):
                self.user.delete_post()
            elif(choice == "7"):
                self.user.update_post()
            elif(choice == "8"):
                self.user.show_friends_details()
            elif(choice == "9"):
                break
            else:
                print("Invalid choice")

    def admin_screen_main(self):
        os.system('clear')
        return_msg = "Hello Admin!"
        while True:
            os.system("clear")
            print(return_msg)
            print("1. Add User")
            print("2. Manage Courses")
            print("3. Add Subject")
            print("4. Add Language")
            print("5. See stats")
            print("6. Exit")

            selection = input()
            if(selection == "1"):
                return_msg = self.admin.add_user()
            elif(selection == "2"):
                os.system("clear")
                print("1. Add Course")
                print("2. Remove Course")
                print("3. Back")
                selection = input()
                while(selection not in ["1", "2","3"]):
                    selection = input("Enter valid option")
                if(selection == "1"):
                    return_msg = self.admin.add_course()
                elif(selection == "2"):
                    return_msg = self.admin.delete_course()
                else:
                    continue
            elif(selection == "3"):
                return_msg = self.admin.add_subject()
            elif(selection == "4"):
                return_msg = self.admin.add_language()
            elif(selection == "5"):
                return_msg = self.admin_stats_screen()
            elif(selection == "6"):
                break
            else:
                print("Invalid option") 
    
    def see_available(self, table):
        refine = False
        while(True):
            os.system("clear")
            print("1. See all")
            print("2. Search by")
            print("3. Back")
            choice = input()
            if(choice == "1"):
                break
            elif(choice == "2"):
                os.system("clear")
                print("1. Language")
                print("2. Subject")
                print("3. Name")
                print("4. Back")
                refine = input()
                if(refine not in ["1","2","3","4"]):
                    print("Invalid choice")
                    continue
                if(refine == "4"):
                    continue
                break
            elif(choice == "3"):
                result = self.see_all(table)
                courseid = input("Enter CourseID: ")
                try:
                    sql_query = "SELECT CourseName, CourseRating FROM `COURSE` WHERE CourseID = %s"
                    self.cursor.execute(sql_query, courseid)
                    result = self.cursor.fetchall()
                    table_format(result)
                except:
                    print("Error")
                
            elif(choice == "4"):
                return
            else:
                print("Invalid choice")
    
        if(not(refine)):
            self.see_all("COURSE")
            input()
        elif(refine == "1"):
            values = self.see_all("LANGUAGE")
            choice = input("Pick language index: ")
            try:
                choice = int(choice)
                lang_code = values[choice-1]['LangCode']
            except:
                print("Error")
            sql_query = "SELECT CourseName, LangCode FROM `COURSE` NATURAL JOIN `USED_FOR` WHERE LangCode = %s"
            self.cursor.execute(sql_query, lang_code)
            result = self.cursor.fetchall()
            table_format(result)
            input()

        elif(refine == "2"):
            values = self.see_all("SUBJECT")
            choice = input("Pick subject index: ")
            try:
                choice = int(choice)
                subname = values[choice-1]['SubName']
                sql_query = "SELECT CourseName, SubName FROM `COURSE` NATURAL JOIN `CONTAINS` WHERE SubName = %s"
                self.cursor.execute(sql_query, subname)
                result = self.cursor.fetchall()
                table_format(result)
                input()
            except:
                print("Error")
            
        elif(refine == "3"):
            choice = input("Enter course name: ")
            sql_query = "SELECT * FROM `COURSE` WHERE CourseName LIKE '%{}%'"        
            self.cursor.execute(sql_query.format(choice))
            result = self.cursor.fetchall()
            table_format(result)
            input()

    def admin_stats_screen(self):
        while(True):
            os.system("clear")
            print("1. Average user performance with friends in course")
            print("2. Back")
            choice = input()
            if(choice == "1"):
                self.admin.stat1()
                break
            elif(choice == "2"):
                break

    def see_all(self, table):
        sql_query = f'SELECT * FROM {table};'
        self.cursor.execute(sql_query)
        result = self.cursor.fetchall()
        table_format(result)
        return result

    def main_screen(self):
        os.system("clear")
        print("Welcome to Open Source University")
        print("1. Admin")
        print("2. User")
        print("3. Exit")
        choice = input()
        if(choice == "1"):
            self.admin_screen_main()
        elif(choice == "2"):
            self.login_screen()
        elif(choice == "3"):
            return 0
        else:
            print("invalid choice")
            input()
        return

def main():
    session = Session()
    while(True):
        if(session.main_screen() == 0):
            break
    

if(__name__ == "__main__"):
    main()