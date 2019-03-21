/*
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

let index=0;
let filesurl=[];
let filesindex=[];
//Check File API support
var myElement = document.getElementById('my-element');
var pics = JSON.parse(myElement.dataset.pics);
var output = document.getElementById("result");
var filesInput = document.querySelector('input[type=file]')

for (var k = 0; k < pics.length; k++) {
    var picFile= pics[k];
    filesindex.push(index);

    var div = document.createElement("div");
    div.id=index;

    div.className+="pip col-6 col-md-4 col-xl-3 p-2"

    div.innerHTML = ['<img class="img-fluid" src="', picFile.url,'"/><span id="', index,'">x</span>'].join('');

    output.insertBefore(div,output.childNodes[0]);
    $("span[id="+index+"]").click(function(){
    	$(this).parent(".pip").remove();
        for (var h =0;h<filesindex.length; h++) {
        	if (filesindex[h]==$(this).attr('id')){
        		filesindex.splice(h,1);
        	}
        }
    });
	index+=1;
}

if(window.File && window.FileList && window.FileReader)
{
    filesInput.addEventListener("change", function(event){

        var files = event.target.files; //FileList object

        for(var i = 0; i< files.length; i++)
        {
            var file = files[i];
            filesurl.push(file);
            filesindex.push(index);
            //Only pics
            if(!file.type.match('image'))
                continue;

            var picReader = new FileReader();

            picReader.addEventListener("load",function(event){

                var picFile = event.target;

                var div = document.createElement("div");
                div.id=index;

                div.className+="pip col-6 col-md-4 col-xl-3 p-2"

                div.innerHTML = ['<img class="img-fluid" src="', picFile.result, '"/><span id="', index,'">x</span>'].join('');

                output.insertBefore(div,output.childNodes[0]);
                $("span[id="+index+"]").click(function(){
			    	$(this).parent(".pip").remove();
			        for (var j =0;j<filesindex.length; j++) {
			        	if (filesindex[j]==$(this).attr('id')){
			        		filesindex.splice(j,1);
			        		filesurl.splice(j,1);
			        	}
			        }
        console.log(filesurl);


			    });
            });
        	index+=1;

            //Read the image
            picReader.readAsDataURL(file);
        }

    });
}
else
{
    console.log("Your browser does not support File API");
}

$("input[type=file]").change(function(){
    console.log(formData);
	alert("UJU")
    var formData = new FormData(); 
    formData.append('email', 'foo@bar.com');
	$.ajax({
		url: '/servicesz',
		type: 'PUT',
        data: formData,
        contentType: false,
        processData: false,
		success: function(data) {
			alert("Successful");
		},
		failure: function() {
			alert("Unsuccessful");
		}
    });
})
*/
$( "input[type=file]" ).change(function() {
    $('#update_pictures').val(true);
    $( 'form' ).submit();
});
