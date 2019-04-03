var input = document.getElementsByClassName("phone");
var hidden=document.getElementsByClassName("phonehidden");
var iti1=window.intlTelInput(input[0],{
	nationalMode: true,
	initialCountry: "ec"
});
var iti2=window.intlTelInput(input[1],{
	nationalMode: true,
	initialCountry: "ec"
});

input[0].addEventListener('focusout',function(){
	hidden[0].value = (iti1.isValidNumber()) ? iti1.getNumber()+"" : "" ;
});

input[1].addEventListener('focusout',function(){
	hidden[1].value=(iti2.isValidNumber()) ? iti1.getNumber()+"" : "" ;
});

