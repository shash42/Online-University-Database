def ask_user_action(fun_name):
    print("Oops, you entered something wrong or missed something")
    while(True):
        print("1. Retry")
        print("2. Exit")
        choice = input()
        if(choice == "1"):
            fun_name()
            break
        elif(choice == "2"):
            return
        else:
            print("Invalid choice")
    return