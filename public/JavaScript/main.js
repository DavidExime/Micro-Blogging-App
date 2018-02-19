
var password = document.getElementById('password');
var message = document.getElementById('message');
var submit = document.getElementById('submit');
var signupForm = document.getElementById("signupForm");
var str;

// submit.addEventListener('click', checkPass());


function checkPass(str){
    var num = /\d+/
    str = password.value
	if(str.length >=6){
		if (str.match(num)){
			signupForm.submit();
			message.innerHTML = 'You got it.'
		} else {
        	password.value = ''
        	message.innerHTML = 'Your password must contain at least 1 digit.'
        }
    } else {
    	console.log('too short')
    	password.value = ''
    	message.innerHTML = 'Your password must contain 6 charactors.'
    }
}

