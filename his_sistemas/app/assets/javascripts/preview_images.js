$( "input[type=file]" ).change(function() {
    $('#update_pictures').val(true);
    form = document.querySelector('form');
    Rails.fire(form, 'submit');
});
