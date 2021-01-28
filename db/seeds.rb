#####USERS#####
user1 = User.create(name: "Bob", email: "bob@gmail.com", password: "bob")
user2 = User.create(name: "Rick", email: "dirklo@gmail.com", password: "dirklo")
user3 = User.create(name: "Terrance", email: "terrance@gmail.com", password: "terrance")
user4 = User.create(name: "George", email: "george@gmail.com", password: "george")
user5 = User.create(name: "Phil", email: "phil@gmail.com", password: "phil")

#####QUIZZES#####
quiz1 = user1.authored_quizzes.create(name: "Food Quiz", date_created: Time.new(2019, 2, 22))
quiz2 = user2.authored_quizzes.create(name: "Animal Quiz", date_created: Time.new(2018, 3, 20))
quiz3 = user1.authored_quizzes.create(name: "Music Quiz", date_created: Time.new(2017, 7, 20))
quiz4 = user3.authored_quizzes.create(name: "Political Quiz", date_created: Time.new(2020, 5, 25))
quiz5 = user3.authored_quizzes.create(name: "Coding Quiz", date_created: Time.new(2019, 2, 3))
quiz6 = user4.authored_quizzes.create(name: "Drinks Quiz", date_created: Time.new(2019, 9, 11))
quiz7 = user4.authored_quizzes.create(name: "Veggies Quiz", date_created: Time.new(2018, 7, 2))
quiz8 = user5.authored_quizzes.create(name: "Video Game Quiz", date_created: Time.new(2017, 4, 12))

#####RESULTS#####
Result.create(user: user1, quiz: quiz6, score: 80, date: Time.new(2021, 1, 2))
Result.create(user: user1, quiz: quiz7, score: 75, date: Time.new(2020, 4, 23))
Result.create(user: user1, quiz: quiz8, score: 90, date: Time.new(2020, 3, 3))
Result.create(user: user2, quiz: quiz3, score: 50, date: Time.new(2020, 7, 18))
Result.create(user: user2, quiz: quiz5, score: 40, date: Time.new(2020, 2, 20))
Result.create(user: user2, quiz: quiz6, score: 90, date: Time.new(2020, 8, 19))
Result.create(user: user2, quiz: quiz8, score: 95, date: Time.new(2019, 9, 12))
Result.create(user: user3, quiz: quiz1, score: 85, date: Time.new(2019, 10, 15))
Result.create(user: user3, quiz: quiz2, score: 70, date: Time.new(2020, 4, 11))
Result.create(user: user3, quiz: quiz3, score: 65, date: Time.new(2020, 6, 7))
Result.create(user: user3, quiz: quiz8, score: 66, date: Time.new(2020, 3, 9))
Result.create(user: user4, quiz: quiz1, score: 70, date: Time.new(2019, 8, 30))
Result.create(user: user4, quiz: quiz2, score: 92, date: Time.new(2018, 3, 23))
Result.create(user: user4, quiz: quiz3, score: 88, date: Time.new(2019, 5, 5))
Result.create(user: user5, quiz: quiz2, score: 30, date: Time.new(2019, 2, 12))
Result.create(user: user5, quiz: quiz4, score: 70, date: Time.new(2020, 8, 17))
Result.create(user: user5, quiz: quiz6, score: 82, date: Time.new(2020, 12, 23))

#####ACCESS#####
UserAccess.create(user: user1, quiz: quiz6, admin: false)
UserAccess.create(user: user1, quiz: quiz7, admin: false)
UserAccess.create(user: user1, quiz: quiz8, admin: false)
UserAccess.create(user: user1, quiz: quiz4, admin: false)
UserAccess.create(user: user2, quiz: quiz3, admin: false)
UserAccess.create(user: user2, quiz: quiz5, admin: false)
UserAccess.create(user: user2, quiz: quiz6, admin: false)
UserAccess.create(user: user2, quiz: quiz8, admin: false)
UserAccess.create(user: user3, quiz: quiz1, admin: false)
UserAccess.create(user: user3, quiz: quiz2, admin: true)
UserAccess.create(user: user3, quiz: quiz3, admin: false)
UserAccess.create(user: user3, quiz: quiz8, admin: false)
UserAccess.create(user: user4, quiz: quiz1, admin: false)
UserAccess.create(user: user4, quiz: quiz2, admin: false)
UserAccess.create(user: user4, quiz: quiz3, admin: false)
UserAccess.create(user: user4, quiz: quiz5, admin: true)
UserAccess.create(user: user5, quiz: quiz2, admin: false)
UserAccess.create(user: user5, quiz: quiz4, admin: false)
UserAccess.create(user: user5, quiz: quiz6, admin: false)

#####QUIZ 1#####
question = quiz1.questions.create(content: "Is a hot dog a sandwich?", kind: "mc_one", order: 1)
question.answers.create(content: "Yes", correct: false, order: 1)
question.answers.create(content: "No", correct: true, order: 2)

question = quiz1.questions.create(content: "Which of these toppings does not belong on pizza?", kind: "mc_one", order: 2)
question.answers.create(content: "Pepperoni", correct: false)
question.answers.create(content: "Pineapple", correct: false)
question.answers.create(content: "Anchovies", correct: true)
question.answers.create(content: "Sausage", correct: false)

question = quiz1.questions.create(content: "Which of these are fruits? (select all that apply)", kind: "mc_many", order: 3)
question.answers.create(content: "Tomato", correct: true)
question.answers.create(content: "Cucumber", correct: false)
question.answers.create(content: "Parsley", correct: false)
question.answers.create(content: "Strawberry", correct: true)
question.answers.create(content: "Parsnip", correct: false)
question.answers.create(content: "Cake", correct: false)

#####QUIZ 2#####
question = quiz2.questions.create(content: "All dogs are descended from what animal?", kind: "fill_in", order: 1)
question.answers.create(content: "wolf", correct: true)
question.answers.create(content: "wolves", correct: true)

question = quiz2.questions.create(content: "How many legs does a spider have?", kind: "mc_one", order: 2)
question.answers.create(content: "8", correct: true, order: 1)
question.answers.create(content: "6", correct: false, order: 2)
question.answers.create(content: "10", correct: false, order: 3)

question = quiz2.questions.create(content: "Which is not a mammal?", kind: "mc_one", limit: 4, order: 3)
question.answers.create(content: "Dragon", correct: true)
question.answers.create(content: "Human", correct: false)
question.answers.create(content: "Platypus", correct: false)
question.answers.create(content: "Chimpanzee", correct: false)
question.answers.create(content: "Beaver", correct: false)
question.answers.create(content: "Bear", correct: false)

#####QUIZ 3#####
question = quiz3.questions.create(content: "Which of these is a string instrument?", kind: "mc_one")
question.answers.create(content: "violin", correct: true)
question.answers.create(content: "guitar", correct: true)
question.answers.create(content: "cello", correct: true)
question.answers.create(content: "oboe", correct: false)
question.answers.create(content: "bassoon", correct: false)
question.answers.create(content: "tuba", correct: false)
question.answers.create(content: "clarinet", correct: false)

question = quiz3.questions.create(content: "Which key has 3 sharps?", kind: "mc_many", limit: 6)
question.answers.create(content: "A Major", correct: true)
question.answers.create(content: "F# Minor", correct: true)
question.answers.create(content: "B Minor", correct: false)
question.answers.create(content: "G Major", correct: false)
question.answers.create(content: "C# Major", correct: false)
question.answers.create(content: "F Major", correct: false)
question.answers.create(content: "B Major", correct: false)

question = quiz3.questions.create(content: "The drums are part of which fammily?", kind: "mc_one")
question.answers.create(content: "Percussion", correct: true)
question.answers.create(content: "Woodwind", correct: false)
question.answers.create(content: "Brass", correct: false)
question.answers.create(content: "Strings", correct: false)

#####QUIZ 4#####
question = quiz4.questions.create(content: "Who is in charge of the Executive Branch?", kind: "fill_in")
question.answers.create(content: "president", correct: true)

question = quiz4.questions.create(content: "How are changes to the Constitution made?", kind: "mc_one", limit: 4)
question.answers.create(content: "Amendments", correct: true)
question.answers.create(content: "The Amendment Process", correct: true)
question.answers.create(content: "Executive Order", correct: false)
question.answers.create(content: "Supreme Court vote", correct: false)
question.answers.create(content: "Popular vote", correct: false)
question.answers.create(content: "Court Appeals Process", correct: false)

question = quiz4.questions.create(content: "Which of these are powers given to ONLY the federal government? (select all that apply)", kind: "mc_many", limit: 6)
question.answers.create(content: "Print Paper Money", correct: true)
question.answers.create(content: "Mint Coins", correct: true)
question.answers.create(content: "Declare War", correct: true)
question.answers.create(content: "Create an Army", correct: true)
question.answers.create(content: "Regulate Trade", correct: false)
question.answers.create(content: "Make New Laws", correct: false)
question.answers.create(content: "Form State Governments", correct: false)
question.answers.create(content: "Define State Borders", correct: false)

#####QUIZ 5#####
question = quiz5.questions.create(content: "What does a user utilize to interact with the web?", kind: "mc_one")
question.answers.create(content: "A Browser", correct: true)
question.answers.create(content: "A Server", correct: false)
question.answers.create(content: "A Controller", correct: false)
question.answers.create(content: "A Model", correct: false)

question = quiz5.questions.create(content: "What do we call the datatype consisting of an ordered set of characters, delineated by quotation marks?", kind: "fill_in")
question.answers.create(content: "string", correct: true)

question = quiz5.questions.create(content: "What are the 3 parts of MVC? (select all that apply)", kind: "mc_many")
question.answers.create(content: "Model", correct: true)
question.answers.create(content: "View", correct: true)
question.answers.create(content: "Controller", correct: true)
question.answers.create(content: "Coding", correct: false)
question.answers.create(content: "Version", correct: false)
question.answers.create(content: "Machine", correct: false)
question.answers.create(content: "Macintosh", correct: false)
question.answers.create(content: "Virus", correct: false)
question.answers.create(content: "Cache", correct: false)

#####QUIZ 6#####
question = quiz6.questions.create(content: "Which of these cocktails typically include vodka?", kind: "mc_one")
question.answers.create(content: "Cosmopolitan", correct: true)
question.answers.create(content: "Old Fashioned", correct: false)
question.answers.create(content: "Gimlet", correct: false)
question.answers.create(content: "Negroni", correct: false)

question = quiz6.questions.create(content: "How many ounces of spirit should a martini contain?", kind: "mc_one")
question.answers.create(content: "2-4oz", correct: true)
question.answers.create(content: "1-2oz", correct: false)
question.answers.create(content: "4-6oz", correct: false)

question = quiz6.questions.create(content: "What are the ingredients in a Tequila Sunrise? (select all that apply)", kind: "mc_many", limit: 6)
question.answers.create(content: "Tequila", correct: true)
question.answers.create(content: "Orange Juice", correct: true)
question.answers.create(content: "Grenadine", correct: true)
question.answers.create(content: "Gin", correct: false)
question.answers.create(content: "Pineapple Juice", correct: false)
question.answers.create(content: "Tonic", correct: false)
question.answers.create(content: "Club Soda", correct: false)
question.answers.create(content: "Cranberry Juice", correct: false)
question.answers.create(content: "Cherry Juice", correct: false)

#####QUIZ 7#####
question = quiz7.questions.create(content: "Which of these is a vegetable?", kind: "mc_one", limit: 4)
question.answers.create(content: "Cucumber", correct: true)
question.answers.create(content: "Strawberry", correct: false)
question.answers.create(content: "Grape", correct: false)
question.answers.create(content: "Orange", correct: false)
question.answers.create(content: "Banana", correct: false)

question = quiz7.questions.create(content: "Which is the worlds most common vegetable?", kind: "mc_one")
question.answers.create(content: "Tomato", correct: true)
question.answers.create(content: "Onion", correct: false)
question.answers.create(content: "Cucumber", correct: false)
question.answers.create(content: "Cabbage", correct: false)

question = quiz7.questions.create(content: "Mushrooms have their own immune system.", kind: "tf")
question.answers.create(content: "True", correct: true)
question.answers.create(content: "False", correct: false)

#####QUIZ 8#####
question = quiz8.questions.create(content: "Which of these characters is blue, runs fast, and collects rings?", kind: "mc_one")
question.answers.create(content: "Sonic the Hedgehog", correct: true)
question.answers.create(content: "Dankey Kang", correct: false)
question.answers.create(content: "Mario", correct: false)
question.answers.create(content: "Pikachu", correct: false)

question = quiz8.questions.create(content: "Which of these are Nintendo consoles?", kind: "mc_many", limit: 6)
question.answers.create(content: "3DS", correct: true)
question.answers.create(content: "Switch", correct: true)
question.answers.create(content: "N64", correct: true)
question.answers.create(content: "PS4", correct: false)
question.answers.create(content: "Playstation", correct: false)
question.answers.create(content: "X-box", correct: false)
question.answers.create(content: "Dreamcast", correct: false)
question.answers.create(content: "Genesis", correct: false)

question = quiz8.questions.create(content: "in GTA: San Andreas, what does 'GTA' Stand for?", kind: "fill_in")
question.answers.create(content: "grand theft auto", correct: true)






