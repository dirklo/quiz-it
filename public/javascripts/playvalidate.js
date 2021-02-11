function checkboxValidate(elClass) {
    group = document.getElementsByClassName(elClass)

    var atLeastOneChecked = false;
    for (i = 0; i < group.length; i++) {
        if (group[i].checked === true) {
            atLeastOneChecked = true;
        }
    }

    if (atLeastOneChecked === true) {
        for (i = 0; i < group.length; i++) {
            group[i].required = false;
        }
    } else {
        for (i = 0; i < group.length; i++) {
            group[i].required = true;
        }
    }
}