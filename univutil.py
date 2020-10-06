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
    headings = ["Index"]+list(result[0].keys())
    values = [(lambda x: list(x.values()))(x) for x in result]
    headings = ["Index"]+list(result[0].keys())
    values = [(lambda x: list(x.values()))(x) for x in result]
    temp = "{}\t"*len(headings)
    print(temp.format(*headings))
    for count, i in enumerate(values):
        print(count+1, end='\t')
        for j in i:
            print(j, end="\t")
        print()