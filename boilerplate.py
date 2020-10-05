from datetime import datetime
import os
import pymysql.cursors
from User import User
from Admin import Admin

class Session:
    
    def __init__(self):
        self.connection = pymysql.connect(host="127.0.0.1",
                              user="root",
                              password="blahblah",
                              db='UNIVERSITY',
                              charset='utf8mb4',
                              port = 5005,
                              cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.connection.cursor()
        self.user = User(self)
        self.admin = Admin(self)
    

    def login_screen(self):
        print("Hello!")
        while True:
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

    def user_screen(self):
        while True:
            print("1. Befriend")
            print("2. Manage Study Group")
            print("3. Interests Update")
            print("4. Show subjects")
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
            elif(choice == "4"):
                self.user.show_subject()
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

    def login(self):
        try:
            UName = input('UserName: ')
            DNumber = int(input('DNumber: '))
            Pass = input('Password: ')
            query = "SELECT Password from `USER` where UserName = '%s' AND DNum = %d" % (UName,DNumber)
            self.cursor.execute(query)
            resultset = self.cursor.fetchone()
            if(not(resultset)):
                print("You need to sign up first")
            else:
                if(resultset['Password'] == Pass):
                    print("Sucessfully logged in")
                    self.user.current_user = [UName,DNumber]
                    self.user_screen()
                    
                else:
                    print("Authentication failed")
            
        except Exception as e:
            print(e)
        return   

    def signup(self):
        self.admin.add_user()
    
    def admin_screen(self):
        os.system('clear')
        print("Hello!")
        while True:
            print("1. Add User")
            print("2. Add Course")
            print("3. Add Subject")
            print("4. Add Language")
            print("5. Exit")

            selection = input()
            if(selection == "1"):
                self.admin.add_user()
            elif(selection == "2"):
                self.admin.add_course()
            elif(selection == "3"):
                self.admin.add_subject()
            elif(selection == "4"):
                self.admin.add_language()
            elif(selection == "5"):
                break
            else:
                print("Invalid option") 

    def see_available(self):
        return
    

    def main_screen(self):
        print("WELCOME TO OPEN SOURCE UNIVERSITY")
        print("1. Admin")
        print("2. User")
        print("3. Exit")
        choice = input()
        if(choice == "1"):
            self.admin_screen()
            
        elif(choice == "2"):
            self.login_screen()
        elif(choice == "3"):
            return 0
            
        else:
            print("invalid choice")
    
        return


def main():
    session = Session()
    while(True):
        if(session.main_screen() == 0):
            break
    

if(__name__ == "__main__"):
    
    main()