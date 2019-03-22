$( "input[type=file]" ).change(function() {
    $('#update_pictures').val(true);
    form = document.querySelector('form');
    Rails.fire(form, 'submit');
});

$( 'input[name=commit]' ).click(function(){
	$('#update_pictures').val(false);
});