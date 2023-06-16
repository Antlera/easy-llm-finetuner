// Description: Script for the evaluation webpage.

let currentQuestionIndex = 1;

// Store the model name mapping for later use.
modelNameMapping = {
    "tuned": "tuned",
    "base": "base",
};

modelFigureMapping = {
    "tuned": "figures/cool_alpaca.jpg",
    "base": "figures/normal_alpaca.jpg"

}

// Store the question data in a mapping for later use.
questionMapping = {};
// Store the question ids in a mapping for later use.
categoryMapping = {};
// Store the number of questions for later use.
questionsCount = 0;


function text2Markdown(text) {
    // Normalize the text for markdown rendering.
    text = text.trim().replaceAll('\n\n', '\n').replaceAll('\n', '\n\n');
    return marked.parse(text);
}

function capitalizeFirstChar(str) {
    if (!str || str.length === 0) {
      return str;
    }
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function updateQuestionSelect(question_id) {
    const select = document.getElementById('question-select');
    // Clear the question select.
    select.innerHTML = '';
    // Populate the question select.
    console.log(questionMapping);
    console.log(question_id);
    console.log(questionMapping[question_id].category);
    category = questionMapping[question_id].category;
    categoryMapping[category].forEach(question_id => {
        const question = questionMapping[question_id];
        const option = document.createElement('option');
        option.value = question_id;
        option.textContent = 'Q' + question_id.toString() + ': ' + question.question;
        select.appendChild(option);
    });
    select.value = question_id;
}

function updateModelSelect() {
    const select = document.getElementById('model-select');
    img_path = modelFigureMapping[select.value];
    document.getElementById('other-model-figure').src = img_path;
}

function populateModels(models) {
    const select = document.getElementById('model-select');
    models.forEach(model => {
        if (model === 'base') {
            return; // 跳过当前迭代，继续下一次迭代
        }
        const option = document.createElement('option');
        option.value = model;
        option.textContent = modelNameMapping[model];
        select.appendChild(option);
    });
    updateModelSelect();
}

function populateQuestions(questions) {
    const category_select = document.getElementById('category-select');

    questionsCount = questions.length;
    questions.forEach(question => {
        const option = document.createElement('option');
        // Store the question data in a mapping for later use.
        questionMapping[question.id] = {
            category: question.category,
            question: question.question,
            answers: question.answers,
            evaluations: question.evaluations,
            scores: question.scores,
        };
        // Store the question id in the category mapping.
        if (question.category in categoryMapping) {
            categoryMapping[question.category].push(question.id);
        } else {
            categoryMapping[question.category] = [question.id];
            const category_option = document.createElement('option');
            category_option.value = question.category;
            category_option.textContent = capitalizeFirstChar(question.category);
            category_select.appendChild(category_option);
        }
    });
    // Set the default category.
    updateQuestionSelect(currentQuestionIndex);
}

function displayQuestion(index) {
    const question = questionMapping[index].question;
    document.getElementById('selected-question').innerHTML = text2Markdown('**Question:** ' + question);
    displayAnswers(index);
}

function displayAnswers(index) {
    const question = questionMapping[index];
    const otherModel = document.getElementById('model-select').value;
    // 剔除 "base" 属性
    // delete question.answers[otherModel].base;
    // render the answers with markdown
    console.log(question.answers);

    document.getElementById('other-model-answer').innerHTML = text2Markdown(question.answers[otherModel]);
    document.getElementById('our-model-answer').innerHTML = text2Markdown(question.answers.base);

    // Display evaluation
    score = question.scores[otherModel];
    score_text = modelNameMapping[otherModel] + " " + score[0] + "/10, base " + score[1] + "/10";
    document.getElementById('evaluation-header').textContent = "GPT-3.5-turbo Evaluation" + " (Score: " + score_text + ")";
    document.getElementById('evaluation-result').innerHTML = text2Markdown(question.evaluations[otherModel]);

    // Update model names
    let assistant1_title = "Assistant #1"; // (" + modelNameMapping[otherModel] + ")";
    let assistant2_title = "Assistant #2 (Base model)";
    // Update scores/labels.
    let assistant1_score_label = score[0].toString() + '/10';
    let assistant2_score_label = score[1].toString() + '/10';

    const colorRed ='#fa9'; // '#eb978d';
    // const colorGreen = '#c9f2c9';
    const colorBlue = '#8ef'; // '#71dbf9';
    const colorYellow = '#fe7'; // '#fada57';
    let otherModelHeaderColor = '';
    let ourModelHeaderColor = '';
    // Update the winner.
    if (score[0] == score[1]) {
        assistant1_title = '🏆 ' + assistant1_title;
        assistant1_score_label = '🏆 ' + assistant1_score_label;
        assistant2_title = '🏆 ' + assistant2_title;
        assistant2_score_label = '🏆 ' + assistant2_score_label;
        otherModelHeaderColor = colorYellow;
        ourModelHeaderColor = colorYellow;
    } else if (score[0] > score[1]) {
        assistant1_title = '🏆 ' + assistant1_title;
        assistant1_score_label = '🏆 ' + assistant1_score_label;
        otherModelHeaderColor = colorBlue;
        ourModelHeaderColor = colorRed;
    } else if (score[0] < score[1]) {
        assistant2_title = '🏆 ' + assistant2_title;
        assistant2_score_label = '🏆 ' + assistant2_score_label;
        otherModelHeaderColor = colorRed;
        ourModelHeaderColor = colorBlue;
    }

    document.getElementById('other-model-header-bg').style.backgroundColor = otherModelHeaderColor;
    document.getElementById('our-model-header').style.backgroundColor = ourModelHeaderColor;

    document.getElementById('other-model-header').textContent = assistant1_title;
    document.getElementById('our-model-header').textContent = assistant2_title;

    document.getElementById('other-score-label').textContent = assistant1_score_label;
    document.getElementById('our-score-label').textContent = assistant2_score_label;

    // Update expand buttons visibility for both cards after displaying answers
    // Reset the expanded state and update expand buttons visibility for both cards after displaying answers
    document.querySelectorAll('.expandable-card').forEach(card => {
        card.classList.remove('expanded');
        updateExpandButtonVisibility(card);
        const expandBtn = card.querySelector('.expand-btn');
        expandBtn.innerHTML = '<i class="material-icons" style="pointer-events: none">keyboard_arrow_down</i> Show more';   // .textContent = 'Show more';
    });
}

document.getElementById('question-select').addEventListener('change', e => {
    currentQuestionIndex = parseInt(e.target.value);
    displayQuestion(currentQuestionIndex);
});

document.getElementById('category-select').addEventListener('change', e => {
    let currentCategory = e.target.value;
    const questionIds = categoryMapping[currentCategory];
    currentQuestionIndex = questionIds[0];
    updateQuestionSelect(currentQuestionIndex);
    displayQuestion(currentQuestionIndex);
});

// Update expand buttons whenever the model is changed
document.getElementById('model-select').addEventListener('change', () => {
    displayAnswers(currentQuestionIndex);
    document.querySelectorAll('.expandable-card').forEach(card => {
        updateExpandButtonVisibility(card);
    });
    updateModelSelect();
});

function switchQuestionAndCategory() {
    document.getElementById('question-select').value = currentQuestionIndex;
    old_category = document.getElementById('category-select').value;
    new_category = questionMapping[currentQuestionIndex].category;
    if (old_category != new_category) {
        document.getElementById('category-select').value = new_category;
        updateQuestionSelect(currentQuestionIndex);
    }
    displayQuestion(currentQuestionIndex);
}

document.getElementById('prev-question').addEventListener('click', () => {
    // Question index starts from 1.
    currentQuestionIndex = Math.max(1, currentQuestionIndex - 1);
    switchQuestionAndCategory();
});

document.getElementById('next-question').addEventListener('click', () => {
    // Question index starts from 1.
    currentQuestionIndex = Math.min(questionsCount, currentQuestionIndex + 1);
    switchQuestionAndCategory();
});

function updateExpandButtonVisibility(card) {
    const cardTextContainer = card.querySelector('.card-text-container');
    const expandBtn = card.querySelector('.expand-btn');
    if (cardTextContainer.scrollHeight > cardTextContainer.offsetHeight) {
        expandBtn.style.display = 'flex';
    } else {
        expandBtn.style.display = 'none';
        card.classList.add('expanded');
    }
}

document.querySelectorAll('.expand-btn').forEach(btn => {
    btn.addEventListener('click', e => {
        const card = e.target.closest('.expandable-card');
        card.classList.toggle('expanded');
        const more = '<i class="material-icons" style="pointer-events: none">keyboard_arrow_down</i> Show more';
        const less = '<i class="material-icons" style="pointer-events: none">keyboard_arrow_up</i> Show less';
        e.target.innerHTML = card.classList.contains('expanded') ? less : more;
    });
});
