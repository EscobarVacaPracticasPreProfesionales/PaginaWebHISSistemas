$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'es-ES',
  });
});
$("#summernote").summernote({
        height: 300,
        lang: 'es-ES',
        toolbar: [
            [ 'style', [ 'style' ] ],
            [ 'font', [ 'bold', 'italic', 'underline'] ],
            [ 'fontsize', [ 'fontsize' ] ],
            [ 'color', [ 'color' ] ],
            [ 'para', [ 'ol', 'ul', 'paragraph', 'height' ] ],
            [ 'table', [ 'table' ] ],
            [ 'insert', [ 'link'] ],
            [ 'view', [ 'undo', 'redo', 'fullscreen', 'help' ] ]
        ]
    });

