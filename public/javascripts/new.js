document.querySelector('#q1_add_answer').addEventListener('click', () => {
    currentAnswer = parseInt(document.getElementById(`q1_answers`).lastElementChild.id[4])
    addAnswer(1, currentAnswer + 1)
});

document.querySelector('#add_question').addEventListener('click', () => {
    currentQuestion = parseInt(document.getElementById('questions_container').lastElementChild.id[1])
    addQuestion(currentQuestion + 1)
});

function addAnswer(questionNum, answerNum) {
    var div = document.createElement('div');
    div.setAttribute('id', `q${questionNum}_a${answerNum}`);
    div.setAttribute('class', "answer_div")
    div.innerHTML = `
        <h3>Answer ${answerNum}:</h3>
        <div>
            <label for="q${questionNum}_a${answerNum}_content" class="answer_content_label">Enter the answer:</label>
            <input type="text" id="q${questionNum}_a${answerNum}_content" class="answer_content_input" name="questions[][answers][][content]">
        </div>
        <br>
        <div>
            <label for="q${questionNum}_a${answerNum}_correct" class="answer_correct_label">Correct Answer?</label>
            <input type="checkbox" id="q${questionNum}_a${answerNum}_correct" class="answer_correct_input" name="questions[][answers][][correct]" value="true">
        </div>
        <br>
        <button type="button" id="q${questionNum}_a${answerNum}_delete_button" class="answer_delete_button" onclick="deleteAnswer(${questionNum}, ${answerNum})">Delete Answer</button>
    `;
    document.getElementById(`q${questionNum}_answers`).appendChild(div);
    setLimit(questionNum);
}

function deleteAnswer(questionNum, answerNum) {
    // DELETING ANSWER DIV
    let answersDiv = document.getElementById(`q${questionNum}_answers`);
    var oldAnswerDiv = document.getElementById(`q${questionNum}_a${answerNum}`);
    answersDiv.removeChild(oldAnswerDiv);
    renumberAnswers(questionNum)
};

function renumberAnswers(questionNum) {
    // RENUMBERING REMAINING ANSWER DIVS
    var answers = document.getElementById(`q${questionNum}_answers`);
    var answerDivs = answers.getElementsByClassName('answer_div');
    var answerTitles = answers.getElementsByTagName('h3');
    var answerContentLabels = answers.getElementsByClassName('answer_content_label');
    var answerContentInputs = answers.getElementsByClassName('answer_content_input');
    var answerCorrectLabels = answers.getElementsByClassName('answer_correct_label');
    var answerCorrectInputs = answers.getElementsByClassName('answer_correct_input');
    var answerDeleteButtons = answers.getElementsByClassName('answer_delete_button');
    for (let i = 0; i < answerDivs.length; i++) {
        answerDivs[i].id = `q${questionNum}_a${i + 1}`;
        answerTitles[i].innerText = `Answer ${i + 1}:`;
        answerContentLabels[i].setAttribute('for', `q${questionNum}_a${i + 1}_content`);
        answerContentInputs[i].id = `q${questionNum}_a${i + 1}_content`;
        answerCorrectLabels[i].setAttribute('for', `q${questionNum}_a${i + 1}_correct`);
        answerCorrectInputs[i].id = `q${questionNum}_a${i + 1}_correct`;
        if (answerDeleteButtons[i]) {
            answerDeleteButtons[i].id = `q${questionNum}_a${i + 2}_delete_button`;
            answerDeleteButtons[i].setAttribute('onclick', `deleteAnswer(${questionNum}, ${i + 2})`);
        };
    };

    // SETTING THE ANSWER LIMIT ON THIS QUESTION
    setLimit(questionNum)
}

function setLimit(questionNum) {
    let totalAnswers = document.getElementById(`q${questionNum}_answers`).children.length        
    let limit = document.getElementById(`q${questionNum}_limit`)
    limit.value = totalAnswers
    limit.max = totalAnswers
}

function addQuestion(questionNum) {
    var article = document.createElement("article")
    article.setAttribute('id', `q${questionNum}`);
    article.setAttribute('class', 'question_article');
    article.innerHTML = `
    <h2>Question ${questionNum}:</h2>
        <div>
            <button type="button" id="q${questionNum}_delete_button" class="question_delete_button" onclick="deleteAndRenumberQuestions(${questionNum})">Delete Question</button>
        </div>
        <div>
            <label for="q${questionNum}_kind" class="question_kind_label">Select the question type:</label>
            <select id="q${questionNum}_kind" class="question_kind_input" name="questions[][kind]">
                <option value="">--Please choose an option--</option>
                <option value="mc_many">Multiple Choice: Many Correct Answers</option>
                <option value="mc_one">Multiple Choice: One Correct Answer</option>
            </select>
        </div>
        <br>
        <div>
            <label for="q${questionNum}_content" class="question_content_label">Enter the Question:</label>
            <input type="text" id="q${questionNum}_content" class="question_content_input" name="questions[][content]">
        </div>
        <br>
        <div>
            <label for="q${questionNum}_limit" class="question_limit_label">How many total answer options should there be?:</label>
            <input type="number" id="q${questionNum}_limit" class="question_limit_input" name="questions[][limit]" value="1" max="1" min="1">
        </div>
        <div id="q${questionNum}_answers" class="answers_container">
            <div id="q${questionNum}_a1" class="answer_div">
                <h3>Answer 1:</h3>
                <div>
                    <label for="q${questionNum}_a1_content" class="answer_content_label">Enter the answer:</label>
                    <input type="text" id="q${questionNum}_a1_content" class="answer_content_input" name="questions[][answers][][content]">
                </div>
                <br>
                <div>
                    <label for="q${questionNum}_a1_correct" class="answer_correct_label">Correct Answer?</label>
                    <input type="checkbox" id="q${questionNum}_a1_correct" class="answer_correct_input" name="questions[][answers][][correct]" value="true">
                </div>
                <br>
            </div> 
        </div>
        <div>
            <button type="button" id="q${questionNum}_add_answer">Add Answer</button>
        </div>
    `;
    document.getElementById('questions_container').appendChild(article);
    
    document.querySelector(`#q${questionNum}_add_answer`).addEventListener('click', () => {
        currentAnswer = parseInt(document.querySelector(`#q${questionNum}_answers`).lastElementChild.id[4])
        addAnswer(questionNum, currentAnswer + 1)
    })
}

function deleteAndRenumberQuestions(questionNum) {
    // DELETING QUESTION DIV
    var questionsContainer = document.getElementById('questions_container');
    var oldQuestionDiv = document.getElementById(`q${questionNum}`);
    questionsContainer.removeChild(oldQuestionDiv);

    // RENUMBERING REMAINING QUESTION DIVS
    var questionArticles = questionsContainer.getElementsByClassName('question_article');
    var questionTitles = questionsContainer.getElementsByTagName('h2');
    var questionKindLabels = questionsContainer.getElementsByClassName('question_kind_label');
    var questionKindInputs = questionsContainer.getElementsByClassName('question_kind_input');
    var questionContentLabels = questionsContainer.getElementsByClassName('question_content_label');
    var questionContentInputs = questionsContainer.getElementsByClassName('question_content_input');
    var questionLimitLabels = questionsContainer.getElementsByClassName('question_limit_label');
    var questionLimitInputs = questionsContainer.getElementsByClassName('question_limit_input');
    var questionDeleteButtons = questionsContainer.getElementsByClassName('question_delete_button');
    var answerContainers = questionsContainer.getElementsByClassName('answers_container');
    for (let i = 0; i < questionArticles.length; i++) {
        questionArticles[i].id = `q${i + 1}`;
        questionTitles[i].innerText = `Question ${i + 1}:`;
        questionKindLabels[i].setAttribute('for', `q${i + 1}_kind`);
        questionKindInputs[i].id = `q${i + 1}_kind`;
        questionContentLabels[i].setAttribute('for', `q${i + 1}_content`);
        questionContentInputs[i].id = `q${i + 1}_content`;
        questionLimitLabels[i].setAttribute('for', `q${i + 1}_limit`);
        questionLimitInputs[i].id = `q${i + 1}_limit`;
        answerContainers[i].id = `q${i + 1}_answers`
        if (questionDeleteButtons[i]) {
            questionDeleteButtons[i].id = `q${i + 2}_delete_button`;
            questionDeleteButtons[i].setAttribute('onclick', `deleteAndRenumberQuestions(${i + 2})`);
        };
    };
    // debugger
    for (let i = 0; i < answerContainers.length; i++) {
        renumberAnswers(i + 1);
    }
}