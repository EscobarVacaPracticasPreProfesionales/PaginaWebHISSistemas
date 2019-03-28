$(document).ready(function(){
  var initial_form_state = $('form').serialize();
  var clicked=false;

  $(this).on('change',"input[type=file]" ,{},function(){
      $('#update_pictures').val(true);
      form = document.querySelector('form');
      Rails.fire(form, 'submit');
  });

  $(this).on('click','input[name=commit]' ,{},function(){
  		$('#update_pictures').val(false);
      clicked=true;
  });

  $(window).bind('beforeunload', function(e) {
    var form_state = $('form').serialize();
    console.log(initial_form_state);
    console.log(form_state);
    if(initial_form_state != form_state && !clicked){
      e.preventDefault();
      var message = "¿Seguro?";
      e.returnValue = message;
      return message;
    }
  });

  $(this).on('focusout',"#reference_year",{},function (evt) {
    min=$(this).attr('min');
    max=$(this).attr('max');
    if ($(this).val().length==0 || parseInt($(this).val()) > max || parseInt($(this).val()) < min){
      $(this).val((new Date).getFullYear());
    }
    /*else if (parseInt($(this).val()) > max){
      $(this).val(max)
    }
    else if(parseInt($(this).val()) < min){
      $(this).val(min)
    }*/
  });

})
