@eyes
@no_mobile
Feature: Courses page

@as_student
Scenario: Student courses
  Given I am on "http://studio.code.org/home"
  When I open my eyes to test "student courses"
  And I wait to see ".headerlinks"
  And I see "#header-student-courses"
  And I press "header-student-courses"
  And I wait to see "#student-page-header"
  And I see no difference for "student courses page"
  And I close my eyes

@as_teacher
Scenario: Teacher courses
  Given I am on "http://studio.code.org/home"
  When I open my eyes to test "teacher courses"
  And I wait to see ".headerlinks"
  And I see "#header-teacher-courses"
  And I press "header-teacher-courses"
  And I wait to see "#curriculum-catalog-container"
  And I see no difference for "teacher courses page"
  And I close my eyes

@as_student
Scenario: Student courses, non-english
  When I open my eyes to test "student courses non-english"
  Given I am on "http://studio.code.org/home/lang/es"
  Then I wait until I am on "http://studio.code.org/home?lang=es"
  And I wait to see ".headerlinks"
  And I see "#header-student-courses"
  And I press "header-student-courses"
  And I wait to see "#student-page-header"
  And I see no difference for "student non-english courses page"
  And I close my eyes

Scenario: Signed out courses, learn
  When I open my eyes to test "signed out courses, learn"
  Given I am on "http://code.org/"
  And I dismiss the language selector
  And I wait to see "#headerlinks"
  And I see "#header-learn"
  And I press "header-learn"
  Then I am on "http://code.org/students"
  And I see no difference for "signed-out courses page, learn"
  And I close my eyes

Scenario: Signed out courses, teach
  When I open my eyes to test "signed out courses, teach"
  Given I am on "http://code.org/"
  And I dismiss the language selector
  And I wait to see "#headerlinks"
  And I see "#header-teach"
  And I press "header-teach"
  Then I am on "https://code.org/teach"
  And I see no difference for "signed-out courses page, teach"
  And I close my eyes

Scenario: Signed out courses, non-english
  When I open my eyes to test "signed out courses, non-english"
  Given I am on "http://studio.code.org/home/lang/es"
  Then I wait until I am on "http://studio.code.org/users/sign_in"
  And I wait to see ".headerlinks"
  And I see "#header-learn"
  And I press "header-learn"
  Then I am on "http://code.org/students"
  And I wait to see "#sign-in-button"
  And I see no difference for "signed-out courses page, non-english"
  And I close my eyes
