$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'es-ES',
  });
});
$("#summernote").summernote({
        followingToolbar: false,
        height: 300,
        lang: 'es-ES',
        toolbar: [
            [ 'font', [ 'bold', 'italic', 'underline'] ],
            [ 'color', [ 'color' ] ],
            [ 'para', [ 'ol', 'ul', 'paragraph', 'height' ] ],
            [ 'table', [ 'table' ] ],
            [ 'insert', [ 'link'] ],
            [ 'view', [ 'undo', 'redo', 'fullscreen', 'help' ] ]
        ]
    });

