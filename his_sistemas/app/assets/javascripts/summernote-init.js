$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'es-ES',
  });
});
$("#summernote").summernote({
        followingToolbar: false,
        height: 300,
        lang: 'es-ES',
            'fontNames': ['Lato', 'Montserrat', 'Raleway'],

        toolbar: [
            ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            [ 'font', [ 'bold', 'italic', 'underline'] ],
            [ 'color', [ 'color' ] ],
            [ 'para', [ 'ol', 'ul', 'paragraph', 'height' ] ],
            [ 'table', [ 'table' ] ],
            [ 'insert', [ 'link', 'hr'] ],
            [ 'view', [ 'undo', 'redo', 'fullscreen', 'help' ] ]
        ]
    });

