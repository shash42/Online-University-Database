from datetime import datetime
import os
import pymysql.cursors
from User import User
from Admin import Admin

class Session:
    
    def __init__(self):
        self.connection = pymysql.connect(host='localhost',
                              user="daa",
                              password="adrcrony69",
                              db='UNIVERSITY',
                              cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.connection.cursor()
        self.user = User(self)
        self.admin = Admin(self)
    
    def login_screen(self):
        os.system("clear")
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
        os.system("clear")
        while True:
            print("1. Mange Friends")
            print("2. Manage Study Group")
            print("3. Update Profile")
            print("4. Explore")
            print("5. Exit")
            choice = input()
            if(choice == "1"):
                self.user.befriend()
            elif(choice == "2"):
                self.user.manage_studygroup()
            elif(choice == '3'):
                self.user.update_interest()
            elif(choice == '4'):
                self.see_available_screen("SUBJECT")
            elif(choice == "5"):
                break
            else:
                print("Invalid choice")

    def login(self):
        os.system("clear")
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
    
    def admin_screen_main(self):
        os.system('clear')
        return_msg = "Hello Admin!"
        while True:
            os.system("clear")
            print(return_msg)
            print("1. Add User")
            print("2. Add Course")
            print("3. Add Subject")
            print("4. Add Language")
            print("5. Exit")

            selection = input()
            if(selection == "1"):
                return_msg = self.admin.add_user()
            elif(selection == "2"):
                return_msg = self.admin.add_course()
            elif(selection == "3"):
                return_msg = self.admin.add_subject()
            elif(selection == "4"):
                return_msg = self.admin.add_language()
            elif(selection == "5"):
                break
            else:
                print("Invalid option") 
    
    def see_available(self, table):
        sql_query = f'SELECT * FROM {table};'
        self.cursor.execute(sql_query)
        result = self.cursor.fetchall()
        headings = list(result[0].keys())
        values = [(lambda x: list(x.values()))(x) for x in result]
        print(values)
        temp = "{:10}"*len(headings)
        print(temp.format(headings[0]))
        for i in values:
            for j in i:
                print(j, end="\t")
            print()
    

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
    
        return


def main():
    session = Session()
    while(True):
        if(session.main_screen() == 0):
            break
    

if(__name__ == "__main__"):
    
    main()