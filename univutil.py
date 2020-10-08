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
   

def table_format(result):
    if(len(result) == 0):
        return 0
    headings = ["Index"]+list(result[0].keys())
    values = [(lambda x: list(x.values()))(x) for x in result]
    temp = "{:<18}"*len(headings)
    print(temp.format(*headings))
    for count, i in enumerate(values):
        i = [count+1]+i
        i = [k if k!=None else "NA" for k in i]
        print(temp.format(*i))
    return 1