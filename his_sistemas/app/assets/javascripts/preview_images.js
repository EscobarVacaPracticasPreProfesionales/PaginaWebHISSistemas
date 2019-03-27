$(document).on('change',"input[type=file]" ,{},function(){
    $('#update_pictures').val(true);
    form = document.querySelector('form');
    Rails.fire(form, 'submit');
});

$(document).on('click','input[name=commit]' ,{},function(){
		$('#update_pictures').val(false);
});

    // Store form state at page load
var initial_form_state = $('form').serialize();

    // Store form state after form submit
$('form').submit(function(){
  initial_form_state = $('form').serialize();
});

    // Check form changes before leaving the page and warn user if needed
$(window).bind('beforeunload', function(e) {
  var form_state = $('form').serialize();
  if(initial_form_state != form_state){
    e.preventDefault();
    var message = "el webo?";
    e.returnValue = message;
    return message;
  }
});
   
