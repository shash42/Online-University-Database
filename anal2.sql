def update_usercontrib(self, sg_url):
        try:
            os.system("clear")
            print("User List: ")
            userquery = "SELECT UserName, DNum, UserSgRole FROM MEMBER_OF WHERE SgUrl = '%s'" % (sg_url)
            self.sesh.cursor.execute(userquery)
            result = self.sesh.cursor.fetchall()
            table_format(result)
            
            roles = ["Member", "Admin"]
            roleidx = 0
            flag = 0
            while(flag==0):
                username = input("Enter username: ")
                dnum = int(input("Enter dnum"))
                for r in result:
                    if(r["UserName"] == username and r["DNum"] == dnum):
                        flag = 1
                        if(r["UserSgRole"] == "Admin"):
                            roleidx = 1
                if(flag==0):
                    print("No such user in study group, try again!")

            contrib = -1
            while(contrib < 0 or contrib > 10):
                contrib = int(input("Contribution rating of user [1-10]: "))
            contribquery = "UPDATE MEMBER_OF SET UserSgContrib = %s WHERE SgUrl = '%s' AND UserName = '%s' AND DNum = %s;" 
            self.sesh.cursor.execute(contribquery, (contrib, sg_url, self.current_user[0], self.current_user[1]))

            selection = 'X'
            while(selection != 'Y' and selection != 'N'):
                selection = input("Flip user role from %s to %s [Y/N]: " % (roles[roleidx], roles[1-roleidx]))
            if(selection == 'Y'):
                rolequery = "UPDATE MEMBER_OF SET UserSgRole = %s WHERE SgUrl = '%s' AND UserName = '%s' AND DNum = %s;"
                self.sesh.cursor.execute(rolequery, (roles[1-roleidx], sg_url, self.current_user[0], self.current_user[1]))
            
            self.sesh.cursor.connection.commit()

        except Exception as e:
            print(e)
            ask_user_action(self.update_usercontrib)

        else:
            print("Contribution updated succesfully!")

        return
