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

<h2> Compliance Report </h2>

We have implemented a super-set of the functional requirements described in our Phase 1 document. We had to make some changes, which are mentioned in CHANGELOG.md

<h4> Selection </h4>

<ol> 
    <li> Show subjects available - User.py/show_subject() </li>
    <li> Show course offerings - </li>
</ol>



<h4> Projection </h4>

<ol>
    <li> List of active study groups for a particular course - User.py/showSgForCourse()</li>
    <li> Obtain passwords for authentication - main.py/login() </li>
    <li> Show available courses by language code or subject name - main.py/see_available()  </li>
    <li> Obtain friends for a user - User.py/show_friends_details() </li>
</ol>



<h4> Aggregation </h4>

<h4> Search </h4>

<ol> 
    <li> Show subjects by keywords (using like) - main.py/see_available() </li>
    <li> Search friend details with a subset of their name - User.py/show_friends_details()</li>

</ol>



<h4> Analysis 1 </h4>

<h4> Analysis 2 </h4>

<h4> Insertion </h4>

<h4> Update </h4>

<h4> Deletion </h4>

<h2> Conclusion </h2>

Special thanks to our mentors Jaidev and Mallika for valuable feedback and clearing our doubts throughout the duration of the course. We hope you enjoy playing with our project (pls resist the urge to break it, we dont like injections :baby: :cry: ) a little more than what we can say for SQL.  