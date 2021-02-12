function addAnswer(questionNum) {
    // ADD ANSWER DIV
    answerNum = parseInt(document.getElementById(`q${questionNum}_answers`).getElementsByClassName('answer_div').length) + 1;
    var div = document.createElement('div');
    div.setAttribute('id', `q${questionNum}_a${answerNum}`);
    div.setAttribute('class', "answer_div");
    div.innerHTML = `
        <div class="answer_title_div">
            <h3>Answer ${answerNum}:</h3>
            <button 
                type="button" 
                id="q${questionNum}_a${answerNum}_delete_button" 
                class="card_delete_button answer_delete_button" 
                onclick="deleteAnswer(${questionNum}, ${answerNum})"
            >
                X
            </button>
        </div>
        <div>
            <input 
                type="text" 
                id="q${questionNum}_a${answerNum}_content" 
                class="answer_content_input" 
                name="questions[][answers][][content]" 
                required
            >
        </div>
        <br>
        <div id="q${questionNum}_a${answerNum}_answer_correct_div" class="answer_correct_div">
            <div>
                <label 
                    for="q${questionNum}_a${answerNum}_correct" 
                    class="answer_correct_label"
                >
                    Correct Answer?
                </label>
                <input 
                    type="checkbox" 
                    id="q${questionNum}_a${answerNum}_correct" 
                    class="answer_correct_input q${questionNum}_correct_input" 
                    name="questions[][answers][][correct]" 
                    value="true"
                    onclick="setLimit(${questionNum})"
                >
            </div>
            <div id="q${questionNum}_a${answerNum}_add_comment_div" class="add_comment_div">
                <button 
                    type="button" 
                    id="q${questionNum}_a${answerNum}_add_comment" 
                    class="comment_button add_comment_button" 
                    onclick="addComment(${questionNum}, ${answerNum})"
                >
                    Add Comment
                </button>
            </div>
        </div>
    `;
    document.getElementById(`q${questionNum}_answers`).appendChild(div);
    setLimit(questionNum);
}

function deleteAnswer(questionNum, answerNum) {
    // DELETE ANSWER DIV
    let answersDiv = document.getElementById(`q${questionNum}_answers`);
    var oldAnswerDiv = document.getElementById(`q${questionNum}_a${answerNum}`);
    answersDiv.removeChild(oldAnswerDiv);
    renumberAnswers(questionNum);
};

function renumberAnswers(questionNum) {
    // RENUMBER REMAINING ANSWER DIVS
    var answers = document.getElementById(`q${questionNum}_answers`);
    var answerDivs = answers.getElementsByClassName('answer_div');
        for (let i = 0; i < answerDivs.length; i++) {
            answerNum = i + 1;
            answerDivs[i].id = `q${questionNum}_a${answerNum}`
            answerDivs[i].getElementsByTagName('h3')[0].innerText = `Answer ${answerNum}:`
            answerDivs[i].getElementsByClassName('answer_content_input')[0].id = `q${questionNum}_a${answerNum}_content`;
            answerDivs[i].getElementsByClassName('answer_correct_label')[0].setAttribute('for', `q${questionNum}_a${answerNum}_correct`);
            answerDivs[i].getElementsByClassName('answer_correct_input')[0].id = `q${questionNum}_a${answerNum}_correct`;
            answerDivs[i].getElementsByClassName('answer_correct_div')[0].id = `q${questionNum}_a${answerNum}_answer_correct_div`;
            if (answerDivs[i].getElementsByClassName('answer_delete_button')[0]) {
                answerDivs[i].getElementsByClassName('answer_delete_button')[0].id = `q${questionNum}_a${answerNum}_delete_button`;
                answerDivs[i].getElementsByClassName('answer_delete_button')[0].setAttribute('onclick', `deleteAnswer(${questionNum}, ${answerNum})`);
            };
            if (answerDivs[i].getElementsByClassName('comment_div')[0]) {
                answerDivs[i].getElementsByClassName('comment_div')[0].id = `q${questionNum}_a${answerNum}_comment_div`;
                answerDivs[i].getElementsByClassName('comment_input')[0].id = `q${questionNum}_a${answerNum}_comment`;
                answerDivs[i].getElementsByClassName('comment_label')[0].setAttribute('for', `q${questionNum}_a${answerNum}_label`);
            };
            if (answerDivs[i].getElementsByClassName('remove_comment_div')[0]) {
                answerDivs[i].getElementsByClassName('remove_comment_div')[0].id = `q${questionNum}_a${answerNum}_remove_comment_div`;
                answerDivs[i].getElementsByClassName('remove_comment_button')[0].id = `q${questionNum}_a${answerNum}_remove_comment_button`;
                answerDivs[i].getElementsByClassName('remove_comment_button')[0].setAttribute('onclick', `removeComment(${questionNum}, ${answerNum})`);
            };
            if (answerDivs[i].getElementsByClassName('add_comment_div')[0]) {
                answerDivs[i].getElementsByClassName('add_comment_div')[0].id = `q${questionNum}_a${answerNum}_add_comment_div`;
                answerDivs[i].getElementsByClassName('add_comment_button')[0].id = `q${questionNum}_a${answerNum}_add_comment_button`;
                answerDivs[i].getElementsByClassName('add_comment_button')[0].setAttribute('onclick', `addComment(${questionNum}, ${answerNum})`);
            };
        }

    // SET THE ANSWER LIMIT ON THIS QUESTION
    setLimit(questionNum);
}

function setLimit(questionNum) {
    let totalAnswers = document.getElementById(`q${questionNum}_answers`).getElementsByClassName('answer_div').length;
    let limit = document.getElementById(`q${questionNum}_limit`);
    let kind = document.getElementById(`q${questionNum}_kind`).value;
    // IF MANY ANSWERS ARE CORRECT FOR mc_one, ANSWER LIMIT SHOULD BE 
    // INCORRECT ANSWERS + 1
    const checkBoxes = new Array(...document.getElementsByClassName(`q${questionNum}_correct_input`));
    const checked = checkBoxes.filter(input => input.checked).length;
    if (checked > 1 && kind === "mc_one") {
        limit.value = totalAnswers - checked + 1;
        limit.max = totalAnswers - checked + 1;
    } else {
        limit.value = totalAnswers
        limit.max = totalAnswers
    };
}

function addQuestion() {
    // ADD QUESTION TO THIS FORM
    questionNum = document.querySelectorAll('.question_article').length + 1;
    var article = document.createElement('article');
    article.setAttribute('id', `q${questionNum}`);
    article.setAttribute('class', 'question_article');
    article.innerHTML = `
        <div class="question_title_div">
            <h2>Question ${questionNum}:</h2>
            <button 
                type="button" 
                id="q${questionNum}_delete_button" 
                class="card_delete_button question_delete_button" 
                onclick="deleteAndRenumberQuestions(${questionNum})"
            >
                X
            </button>
        </div>
        <div>
            <label 
                for="q${questionNum}_kind" 
                class="question_kind_label"
            >
                Select the question type:
            </label>
            <select 
                id="q${questionNum}_kind" 
                class="question_kind_input" 
                name="questions[][kind]"
                onchange="setLimit(${questionNum})"
            >
                <option value="mc_one">One Correct Answer</option>
                <option value="mc_many">Many Correct Answers</option>
            </select>
        </div>
        <br>
        <div>
            <label 
                for="q${questionNum}_content" 
                class="question_content_label"
            >
                Enter the Question:
            </label>
            <input 
                type="text" 
                id="q${questionNum}_content" 
                class="question_content_input" 
                name="questions[][content]" 
                required
            >
        </div>
        <br>
        <div id="q${questionNum}_answers" class="answers_container">
            <div id="q${questionNum}_a1" class="answer_div">
                <h3>Answer 1:</h3>
                <div>
                    <input 
                        type="text" 
                        id="q${questionNum}_a1_content" 
                        class="answer_content_input" 
                        name="questions[][answers][][content]" 
                        required
                    >
                </div>
                <br>
                <div id="q${questionNum}_a1_answer_correct_div" class="answer_correct_div">
                    <div>
                        <label 
                            for="q${questionNum}_a1_correct" 
                            class="answer_correct_label"
                        >
                            Correct Answer?
                        </label>
                        <input 
                            type="checkbox" 
                            id="q${questionNum}_a1_correct" 
                            class="answer_correct_input q${questionNum}_correct_input" 
                            name="questions[][answers][][correct]" 
                            value="true"
                            onclick="setLimit(${questionNum})"
                        >
                    </div>
                    <div id="q${questionNum}_a1_add_comment_div" class="add_comment_div">
                        <button 
                            type="button" 
                            id="q${questionNum}_a1_add_comment" 
                            class="comment_button add_comment_button" 
                            onclick="addComment(${questionNum}, 1)"
                        >
                            Add Comment
                        </button>
                    </div>
                </div>
            </div>
            <div id="q${questionNum}_a2" class="answer_div">
                <h3>Answer 2:</h3>
                <div>
                    <input 
                        type="text" 
                        id="q${questionNum}_a2_content" 
                        class="answer_content_input" 
                        name="questions[][answers][][content]" 
                        required
                    >
                </div>
                <br>
                <div id="q${questionNum}_a2_answer_correct_div" class="answer_correct_div">
                    <div>
                        <label 
                            for="q${questionNum}_a2_correct" 
                            class="answer_correct_label"
                        >
                            Correct Answer?
                        </label>
                        <input 
                            type="checkbox" 
                            id="q${questionNum}_a2_correct" 
                            class="answer_correct_input q${questionNum}_correct_input" 
                            name="questions[][answers][][correct]" 
                            value="true"
                            onclick="setLimit(${questionNum})"
                        >
                    </div>
                    <div id="q${questionNum}_a2_add_comment_div" class="add_comment_div">
                        <button 
                            type="button" 
                            id="q${questionNum}_a2_add_comment" 
                            class="comment_button add_comment_button" 
                            onclick="addComment(${questionNum}, 2)"
                        >
                            Add Comment
                        </button>
                    </div>
                </div>
            </div>  
        </div>
        <div class="add_answer_div">
            <button 
                type="button" 
                id="q${questionNum}_add_answer" 
                class="button button-green" 
                onclick="addAnswer(${questionNum})"
            >
                Add an Answer
            </button>
        </div>
        <br>
        <div>
            <label 
                for="q${questionNum}_limit" 
                class="question_limit_label"
            >
                Answer Limit:
            </label>
            <input 
                type="number" 
                id="q${questionNum}_limit" 
                class="question_limit_input" 
                name="questions[][limit]" 
                value="2" 
                max="2" 
                min="2"
            >
        </div>
        </br>
    `;
    document.getElementsByClassName('questions_card')[0].appendChild(article);
}

function deleteAndRenumberQuestions(questionNum) {
    // DELETE QUESTION ARTICLE
    var questionsContainer = document.getElementsByClassName('questions_card')[0];
    var oldQuestionArticle = document.getElementById(`q${questionNum}`);
    questionsContainer.removeChild(oldQuestionArticle);

    // RENUMBER REMAINING QUESTION ARTICLES
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
    for (let i = 0; i < answerContainers.length; i++) {
        renumberAnswers(i + 1);
    }
}

function addComment(questionNum, answerNum) {
    document.getElementById(`q${questionNum}_a${answerNum}_add_comment_div`).remove()

    var div = document.createElement('div');
    div.setAttribute('id', `q${questionNum}_a${answerNum}_comment_div`)
    div.setAttribute('class', "comment_div")
    div.innerHTML = `
        <label for="q${questionNum}_a${answerNum}_comment" class="comment_label">Comment:</label>
        <input type="text" id="q${questionNum}_a${answerNum}_comment" class="comment_input" name="questions[][answers][][comment]">
    `;
    document.getElementById(`q${questionNum}_a${answerNum}`).appendChild(div);

    var div2 = document.createElement('div');
    div2.setAttribute('id', `q${questionNum}_a${answerNum}_remove_comment_div`)
    div2.setAttribute('class', `remove_comment_div`)
    div2.innerHTML = `
        <button 
            type="button" 
            id="q${questionNum}_a${answerNum}_remove_comment_button"
            class="comment_button remove_comment_button"
            onclick="removeComment(${questionNum}, ${answerNum})"
        >
            Remove Comment
        </button>    
    `;
    document.getElementById(`q${questionNum}_a${answerNum}_answer_correct_div`).appendChild(div2);
}

function removeComment(questionNum, answerNum) {
    document.getElementById(`q${questionNum}_a${answerNum}_remove_comment_div`).remove()
    document.getElementById(`q${questionNum}_a${answerNum}_comment_div`).remove()

    var div = document.createElement('div');
    div.setAttribute('id', `q${questionNum}_a${answerNum}_add_comment_div`)
    div.setAttribute('class', "add_comment_div")
    div.innerHTML = `
        <button 
            type="button" 
            id="q${questionNum}_a${answerNum}_add_comment_button"
            class="comment_button add_comment_button"
            onclick="addComment(${questionNum}, ${answerNum})"
        >
            Add Comment
        </button>
    `;
    document.getElementById(`q${questionNum}_a${answerNum}_answer_correct_div`).appendChild(div);
}