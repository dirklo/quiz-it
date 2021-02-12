# Quiz-It
 Flatiron School, Phase 2 final project using Ruby 2.6.1 and Sinatra. 

A fully functioning quiz creation web application.  

# To install:
1) Clone the github repository to your machine.

2) Run `bundle install` from the root directory to install dependancies.

3) Run `rake db:migrate` to create the development database

4) Run `rake db:seed` to populate database with test quizzes.

5) Run `rackup config.ru` to start the server, which should be listening on localhost:9292 by default.

6) Use Chrome to visit http://localhost:9292/

# Usage:

## Login/Signup

Use the buttons on the home page to create an account or sign into your own.  You will not be able to create an account with a username or email that is already in use.

## My Quizzes

From your My Quizzes page, you are able to Create a New Quiz, view all the quizzes you have created, and all of the quizzes others have shared with you.

You can also access your Quiz History, All Public Quizzes, and Account Settings from this page.

## Create a New Quiz
    
Your new quiz must have a Name, a description and a category.  You can optionally make your quiz public.  This adds the quiz to the All Public Quizzes page, allowing anyone with an account to take the quiz.

New Quizzes default to 1 question with 2 answers.  Questions or answers can be added as needed.  3 formats can be used to create questions for your quiz:

### One Correct Answer:
If you select this type, you can still select more than one answer as correct.
            
If you add more than 1 correct answer, the question will randomly select 1 correct answer and all of the incorrect answers when the quiz is taken.  You can lower the number of incorrect answers andomly selected by lowering the Answer Limit.
            
#### Examples of "One Correct Answer" Questions:

**Question 1:**
>**1** correct answer, **3** incorrect answers, answer limit **4**
>
>>This will display all 4 questions, shuffled, when the quiz is taken.

**Question 2:**
>**3** correct answers, **3** incorrect answers, answer limit **4**
>
>>This will select 1 corect answer at random, 
>>and combine it with the 3 incorrect answers to display 4 total.

**Question 3:**
>**4** correct answers, **6** incorrect answers, answer limit **6** (manually lowered)
>
>>This will select 1 correct answer at randon, 
>>and combine it with 5 incorrect answers to display 6 total.
            
### Many Correct Answers: 
This question type will display all of the correct answers selected, and shuffle them with all of the incorrect answers unless the answer limit is lowered.  All correct answers and no incorrect answers must be selected to recieve full points for the question. 

#### Examples of "Many Correct Answers" Questions:

**Question 4:**
>**3** correct answers, **3** incorrect answers, answer limit **6**
>
>>This will display check boxes for all 3 correct answers and all 3 incorrect answers for a total of 6.

**Question 5:** 
>**4** correct answers, **4** incorrect answers, answer limit **6** (manually lowered)
>
>>This will display all 4 correct answers along with 2 random incorrect answers.
        
You also have the option of adding comments to each question.  This is intended to act as an explination or reinforcement when that answer is selected.

This page will not allow submission with passing a quiz validation. 

## Quiz Home Page
    
Clicking on a quiz will take you to it's home page.  From here, you can take the quiz.

If you are the creator or an administrator on a quiz, you can edit the quiz from here or view it's statistics.

You can only delete the quiz from this page if you are the creator of that quiz.

## Taking a Quiz

You can play a quiz from it's home page.  

### Grading Parameters:

Questions with 1 correct answer are worth 1 point.  You can only select 1 answer.

Questions with many correct answers are worth the number of points as there are correct options.  
You will not lose points for selecting incorrect answers, 
unless your total number of selected answers is greater than the number of total correct answers.

#### Examples:
>**Question 1:** 
>3 correct answers and 3 incorrect answers shown
>>You select the 3 correct answers
>>>You get 3 points out of 3

>**Question 2:** 
>3 correct answers and 3 incorrect answers shown
>>You select 2 correct answers and 1 incorrect answer
>>>You get 2 points out of 3

>**Question 3:** 
>4 correct answers and 4 incorrect answers shown
>>You select 4 correct answers and 2 incorrect answers
>>>You get 2 points out of 4

>Question 3: 
>3 correct answers and 3 incorrect answers shown
>>You select 3 correct answers and 3 incorrect answers
>>>You get 0 points out of 3

## Edit a quiz
    
If a user is the author of a quiz or has been granted administrator access, they can edit a quiz from the quizzes' home page.

All options available when creating a new quiz are available when updating a quiz.  

Additionally, you may access the user access page for the quiz from here, to add or remove the emails of users who should have access to this quiz. Granting admin privelege to an email will allow that user to edit the quiz and view it's statistics, but not delete the quiz.

## All Public Quizzes

Clicking this button from the My Quizzes page will take you to the category list, which contain all the public quizzes that have been created.  You must be logged in to view and take public quizzes.  

## Quiz History

Clicking this button from the My Quizzes page will show you a list of all the quizzes you have taken, the dates they were taken, and your score on that attempt.

## Account Settings

Clicking here will allow you to delete your account.  Deleting your account will result in the loss of all your quizzes and their questions/answers.


