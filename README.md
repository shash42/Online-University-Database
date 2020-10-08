# Online-University-Database
Final Group Project for the Database and Applications Course - Monsoon'20 Semester

<h2> Team Databaes: </h2>

<ul>
    <li>K Aditya Hari </li>
    <li>Prince Varshney </li>
    <li>Shashwat Goel </li>
</ul>

<h2> Brief Overview </h2>

A Menu-based Command Line Interface Database system to support a social networking platform for learning, with study group aggregation for the entire spectrum of courses available on the Internet. More details in our Phase 1 WhitePaper. 

<h2> Usage </h2>

<h4> Requirements </h4>

To run this on your system you need:
1. SQL Server
2. Python Module - PyMySQL

<h4> Installation </h4>

1. To install MySQL in Windows use this link <https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/windows-install-archive.html>   
    For Ubuntu use this link <https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04>   
    For MacOS use this link <https://database.guide/how-to-install-sql-server-on-a-mac/>
2. For Python Libraries run these commands on your terminal-    
   `pip3 install pymysql`     

<h4> Execution </h4>

2. Make sure the user temp is created and exists with all privileges and along with an empty database called UNIVERSITY in your SQL server before running these commands.
2. Loading: <code>mysql -u <em>temp</em> UNIVERSITY < definition.sql</code>

3. Use the command `python main.py` to start the CLI.

<h2> Implemented Features </h2>

A Menu based system was chosen instead of a command-based one to better reflect the different screens that would be available in a full-fledged realisation of this project, which if developed in the real-world would have a GUI to support layman users. <br>

On executing the required command to run the program, you are prompted to choose between the User/Admin view. The User view requires a sign-up and then a log-in, but not the Admin view. <br>

<h3> User Features </h3>

The User view has the functions available to the typical user of our platform

<h4> Manage Connections </h4>

Being a social platform, there is obviously a feature to add friends! This helps you keep in touch with what your friends are learning, join study groups with them, view their blogs and reviews for courses, and a lot more! (in the future ;) )

<h4> Manage Courses/Interests </h4>

Here you can list your interests for the world to see! You can also browse through the vast collection of courses which have study groups linked on our platform, and enroll in the ones of your choice, based on your preferred language, group size, crowd-sourced ratings and much more! 

<h4> Manage Posts </h4>

You can make your own posts (and edit and delete them). These can either be blogs, where you can share your knowledge, talk about what you're upto, how the platform helped you or reviews for a specific course, to let the community know what you think about it! You can also view the posts of your favourite user, which doesn't have to be a friend! Think LinkedIn, but for learning not Imposter Syndrome (even though this README reads like a LinkedIn post, brb, gonna post it there).

<h4> Manage StudyGroups </h4>

As a study group admin, you can manage the information of your study group that is seen by people around the world. You can make changes to reflect user roles, maintain how much they are contributing, add languages, courses and events (both meet announcements and targets). 

As a user, you can currently rate the study groups you are a part of, more features later!

<h3> Admin Features </h3>

The Admin view is from the perspective of the back-end developers.

<h4> The boring stuff </h4>

As an admin, you get to add/delete the availability of courses, subjects, languages, users themselves (ok not so boring), and possible interests.

<h4> The cool stuff</h4>   

But more importantly, you can create analysis reports using the rich variety of data available for selling insigh.. optimising the user experience :eight_pointed_black_star: 2 of these are already implemented and are described in the compliance report!

<h2> Repository Structure </h2>

The folder src contains 4 .py files, main.py, User.py, Admin.py and univutil.py. User.py contains the User class, which has functions for the User view. Similarly, Admin has the Admin class with functions for Admin view. main.py is the caller function that combines these together and prints the initial menus. univutil.py just contains some utility functions needed by multiple files. <br>

The folder References contains the work of the older phases for reference. This shows the progress of the project over time. CHANGELOG.md describes the changes from Phase 3 to 4 (current). definition.sql contains the definition of the UNIVERSITY schema for readability. data.sql loads the definition with some basic test data for exemplifying the working of our database system. <br>

<h2> Compliance Report </h2>

We have implemented a super-set of the functional requirements described in our Phase 1 document. We had to make some changes, which are mentioned in CHANGELOG.md. Apart from the required functionality, we have also used triggers and views extensively. This section describes in detail the exact function where the requirements were met in different ways.

<h4> Selection </h4>

<ol> 
    <li> Show subjects available - User.py/show_subject() </li>
    <li> Show course offerings - User.py/show_offerings() and main.py/see_all()</li>
    <li> Display posts of a user - User.py/view_user_posts() </li>
</ol>


<h4> Projection </h4>

<ol>
    <li> List of active study groups for a particular course - User.py/showSgForCourse()</li>
    <li> Show available courses by language code - main.py/see_available()  </li>
    <li> Show available courses by subject name - main.py/see_available()  </li>
    <li> Obtain passwords for authentication - main.py/login() </li>
    <li> Obtain friends for a user - User.py/show_friends_details() </li>
    <li> Show study groups of a user (with constraints on role being Member and Admin)- User.py/rate_sg() and User.py/admin_sg() </li>
    <li> Show languages of a particular study group - User.py/enroll()</li>
    <li> Show role for user in a particular study group - User.py/update_usercontrib()</li>
    <li> Obtain status of a study group - User.py/change_sgstatus()</li>
</ol>

<h4> Aggregation </h4>

<ol>
    <li> Count number of events in a study group - User.py/create_event() </li>
    <li> Count number of posts made by a user - User.py/make_post() </li>
    <li> Show average rating, number of users, number of events of different study groups for a course - User.py/showSgForCourse() </li>
    <li> Multiple used in Analysis 1 and 2</li>
</ol>

<h4> Search </h4>

<ol> 
    <li> Show subjects by keywords (using like) - main.py/see_available() </li>
    <li> Search friend details with a subset of their name - User.py/show_friends_details()</li>
</ol>

<h4> Analysis 1 </h4>

As ours is a social platform, it is important to track the social aspects, i.e. what do the 'friends' in our database share. We do this by tracking the average number of study groups shared between a pair of friends, and the average number of common interests between a pair of friends. This also reveals insights on how students make friends across the globe just by being connected through study groups on our platform!

<h4> Analysis 2 </h4>

Analysis 2 demonstrates the efficacy of the platform, and gives further insights on learning by correlating user outcomes with study groups, and friendships the user had within the study group. This data can not only inform our platform itself, but educators around the world on the value of healthy collaboration in learning. <br>

The analysis generated is for an input-specified course, as mixing data across different styles and content would add noise to the report generated. This also allows individual instructors data to optimize their course accordingly. <br>

User 'outcome' is seen as a mean of the User's performance and the rating the user gives to the course. This is because we believe a learner's satisfaction and motivation must be accounted for in the outcomes as well, not just how well they 'scored'. <br>

The final data presented in this analysis report contains (sorted in descending order of 'outcome') for the particular course each user's number of study groups enrolled, average contribution across these study groups, average rating provided by the user for these groups, average number of students per group, and most interesting of all, average number of "friends" the user has across these study groups. <br>

To show one possible way to quickly use this data, aggregate statistics of the above are shown for the top half and bottom half of  the users based on outcome (again, this is for a particular course) <br>

<h4> Insertion </h4>

<ol>
    <li> Enrolling user in a course+study_group - User.py/enroll() and User.py/addoption_studygroup()</li>
    <li> Create a new study group related to a language and course - User.py/enroll()</li>
    <li> Add languages and courses to a study group - User.py/addoption_stduygroup()</li>
    <li> Add a meet to a study group - User.py/create_meet()</li>
    <li> Add a target to a study group - User.py/create_target() </li>
    <li> Create event in a study group - User.py/create_event() </li>
    <li> Create pin in a study group - User.py/create_pin() </li>
    <li> Add blog/review to a study group - User.py/make_post() </li>
    <li> Add tags to a blog - User.py/make_post() </li>
    <li> Add a friendship relation between users - User.py/befriend() </li>
    <li> Add a user to the database (on signup) - Admin.py/add_user()</li>
    <li> Add a course and it's difficulty (separate queries) - Admin.py/add_course()</li>
    <li> Add languages for a course - Admin.py/add_course() </li>
    <li> Add course to subject - Admin.py/add_course() </li>
    <li> Add a course instructor to a course - Admin.py/add_course() </li>
    <li> Add a prerequisite to a course - Admin.py/add_prerequisite() </li>
    <li> Add a subject - Admin.py/add_subject() </li>
    <li> Add a language - Admin.py/add_language() </li>
    <li> Add a language known to a user - Admin.py/add_languageknown() </li>
</ol>

<h4> Update </h4>

<ol>
    <li> Change status of a study group - User.py/change_sgstatus()</li>
    <li> Update contribution rating for a member - User.py/update_usercontrib()</li>
    <li> Update role of a user - User.py/update_usercontrib() </li>
    <li> Update rating of a study_group as a member - User.py/rate_sg()</li>
    <li> Update a particular post of a user - User.py/update_post() </li>
    <li> Update interest type for a user - User.py/update_interest </li>
</ol>

<h4> Deletion </h4>

<ol>
    <li> Delete a particular post of a user - User.py/delete_post() </li>
    <li> Delete a course - Admin.py/delete_course()</li>
</ol>

<h2> Conclusion </h2>

Special thanks to our mentors Jaidev and Mallika for valuable feedback and clearing our doubts throughout the duration of the course. We hope you enjoy playing with our project (pls resist the urge to break it, we dont like injections :baby: :cry: ) a little more than what we can say for writing all this SQL :stuck_out_tongue:  
