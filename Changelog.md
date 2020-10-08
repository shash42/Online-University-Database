<h1> Changes from Phase 3->4 </h1>

<ol>
    <li> Shifted SgStatus from PARTICIPATES_IN to STUDY_GROUP as it isn't relevant to any other entity in the quarter-nary relationship, and updating it would require changing all tuples with the STUDY_GROUP otherwise. </li>

    <li> Shifted some attributes from PARTICIPATES_IN to 2 newly created relations MEMBER_OF and TAKES for ease of implementation. </li>

    <li> Study group with maximum number of users for a particular courseRecommend study groups for a particular course with average rating, number of events, number of users etc. </li>
    
    <li> Added a password field to the USER relation for authentication </li>
    
    <li> As the analysis reports were specified in an open-ended manner initially, a specific version within the same themes was designed and implemented </li>


</ol>

