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

for (var k = 0; k < pics.length; k++) {
    var picFile= pics[k];
	filesurl.push(picFile.url);
    filesindex.push(index);

    var div = document.createElement("div");
    div.id=index;

    div.className+="pip col-12 col-lg-6 p-2"

    div.innerHTML = ['<img class="img-fluid" src="', picFile.url,'"/><span id="', index,'">x</span>'].join('');

    output.insertBefore(div,null);
    $("span[id="+index+"]").click(function(){
    	$(this).parent(".pip").remove();
        for (var h =0;h<filesindex.length; h++) {
        	if (filesindex[h]==$(this).attr('id')){
        		filesindex.splice(h,1);
        		filesurl.splice(h,1);
        	}
        }
    });
	index+=1;
}

if(window.File && window.FileList && window.FileReader)
{

    var filesInput = document.querySelector('input[type=file]')

    filesInput.addEventListener("change", function(event){

        var files = event.target.files; //FileList object

        for(var i = 0; i< files.length; i++)
        {
            var file = files[i];
            filesurl.push(file.name);
            filesindex.push(index);
            //Only pics
            if(!file.type.match('image'))
                continue;

            var picReader = new FileReader();

            picReader.addEventListener("load",function(event){

                var picFile = event.target;

                var div = document.createElement("div");
                div.id=index;

                div.className+="pip col-12 col-lg-6 p-2"

                div.innerHTML = ['<img class="img-fluid" src="', picFile.result, '" title="', picFile.name, '"/><span id="', index,'">x</span>'].join('');

                output.insertBefore(div,null);
                $("span[id="+index+"]").click(function(){
			    	$(this).parent(".pip").remove();
			        for (var j =0;j<filesindex.length; j++) {
			        	if (filesindex[j]==$(this).attr('id')){
			        		filesindex.splice(j,1);
			        		filesurl.splice(j,1);
			        	}
			        }

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

$("#submit").click(function(){
	console.log(filesurl[0]);
	alert(JSON.stringify(filesurl))
	$.ajax({
		url: '',
		dataType: 'json',
		type: 'PATCH',
		data: {pics: JSON.stringify(filesurl)},
		success: function(data) {
			alert("Successful");
		},
		failure: function() {
			alert("Unsuccessful");
		}
    });
})
