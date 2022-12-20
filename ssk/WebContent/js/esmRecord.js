var newRecordTextArea = document.getElementsByName('newRecordText');
var newRecordSubmit = document.getElementById('newRecordSubmit');

newRecordTextArea[0].addEventListener('input', function (event) {
	if(event.target.value=="") {
		newRecordSubmit.disabled = true;
		newRecordSubmit.style.backgroundColor="#d8d8d8";
		newRecordSubmit.style.color="black";
	}
	else {
		newRecordSubmit.disabled = false;
		newRecordSubmit.style.backgroundColor="#555555";
		newRecordSubmit.style.color="white";
	}
});

