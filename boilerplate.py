from datetime import datetime
import pymysql.cursors 

class Session:
    def __init__(self):
        self.connection = pymysql.connect(host='localhost',
                             user='root',
                             password='password',
                             db='UNIVERSITY',
                             charset='utf8mb4',
                             port = 5005,
                             cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.connection.cursor()
        self.logged_in = False
        self.role = None
    
    def login_screen(self):
        print("Hello!")
        print("1. Login")
        print("2. Sign Up")

        selection = input()
        if(selection == "1"):
            self.login()
        elif(selection == "2"):
            self.signup()
        else:
            print("Invalid option")

    def login(self):
        return   
    def signup(self):
        return
    def user_screen(self):
        return
    def admin_screen(self):
        print("Hello!")
        print("1. Add User")
        print("2. Add Course")
        print("3. Add Subject")
        print("4. Add Language")

        selection = input()
        if(selection == "1"):
            self.add_user()
        elif(selection == "2"):
            self.add_course()
        elif(selection == "3"):
            self.add_subject()
        elif(selection == "4"):
            self.add_language()
        else:
            print("Invalid option") 
    def add_entry_screen(self):
        return
    def see_available(self):
        return

    # User Actions
    def enroll(self):
        return
    def unenroll(self):
        return
    def join_studygroup(self):
        return
    def create_studygroup(self):
        return
    def create_event(self):
        return
    def pin_event(self):
        return
    def make_post(self):
        return
    def befriend(self):
        return
    def update_interest(self):
        return

    # Admin Actions
    def add_user(self):
        try:
            username = input("Username: ")
            dnum = int(input("DNum: "))
            fname = input("First Name: ")
            mname = input("Middle Name: ")
            lname = input("Last Name: ")
            dob = datetime.strptime(input("Date of Birth: "), "%d-%m-%Y")
            email = input("Email: ")
            sql = "INSERT INTO `USER` "
        except:
            print("Hmm")
    def get_dnum(self, username):
        return
    def add_course(self):
        return
    def add_subject(self):
        return
    def add_language(self):
        return
    def add_prerequisite(self):
        return 

def main():
    session = Session()
    while(True):
        session.admin_screen()

if(__name__ == "__main__"):
    
    main()