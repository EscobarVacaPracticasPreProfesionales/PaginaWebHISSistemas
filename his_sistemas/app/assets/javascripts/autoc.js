document.getElementById("submit").addEventListener("click",function(){
	document.getElementById("user_contact_attributes_emailcontact").value=String(document.getElementById("user_email").value)
})

var input = document.getElementsByClassName("phone");
var hidden=document.getElementsByClassName("phonehidden");

input[0].value = hidden[0].value;
input[1].value=hidden[1].value;

