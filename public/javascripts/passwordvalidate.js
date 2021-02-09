var passwordMatchCheck = function() {
    if (document.getElementById('user_password').value ==
      document.getElementById('confirm_password').value) {
      document.getElementById('message').style.color = 'lime';
      document.getElementById('message').innerHTML = 'Looks Good!';
    } else {
      document.getElementById('message').style.color = 'red';
      document.getElementById('message').innerHTML = "Passwords don't match";
    }
  }