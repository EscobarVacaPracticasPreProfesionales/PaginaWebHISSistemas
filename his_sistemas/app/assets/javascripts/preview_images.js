console.log("GG");
let index=0;
let filesurl=[];
let filesindex=[];
//Check File API support
var myElement = document.getElementById('my-element');
var pics = JSON.parse(myElement.dataset.pics);

for (var k = 0; k < pics.length; k++) {
    var file = pics[k];
	filesurl.push(file.name);
    filesindex.push(k);

    var div = document.createElement("div");
    div.id=index;

    div.className+=" col-12 col-lg-6 pt-2 pb-2"

    div.innerHTML = ['<img class="img-fluid" src="', file.url, '" title="', file.name, '"/><span class="remove_img_preview">x</span>'].join('');

        output.insertBefore(div,null);
        div.children[1].addEventListener("click", function(event){
            div.parentNode.removeChild(div);
            for (var j =0;j<filesindex.length; j++) {
            	if (filesindex[j]==div.id){
            		filesindex.splice(j,1);
            		filesurl.splice(j,1);
            	}
            }
            console.log(filesurl);

        });
    	index+=1;
    });

    //Read the image
    picReader.readAsDataURL(file);
}

if(window.File && window.FileList && window.FileReader)
{

    var filesInput = document.querySelector('input[type=file]')

    filesInput.addEventListener("change", function(event){

        var files = event.target.files; //FileList object
        var output = document.getElementById("result");

        for(var i = 0; i< files.length; i++)
        {
            var file = files[i];
            filesurl.push(file.name);
            filesindex.push(i);
            //Only pics
            if(!file.type.match('image'))
                continue;

            var picReader = new FileReader();

            picReader.addEventListener("load",function(event){

                var picFile = event.target;

                var div = document.createElement("div");
                div.id=index;

                div.className+=" col-12 col-lg-6 pt-2 pb-2"

                div.innerHTML = ['<img class="img-fluid" src="', picFile.result, '" title="', picFile.name, '"/><span class="remove_img_preview">x</span>'].join('');

                output.insertBefore(div,null);
                div.children[1].addEventListener("click", function(event){
                    div.parentNode.removeChild(div);
                    for (var j =0;j<filesindex.length; j++) {
                    	if (filesindex[j]==div.id){
                    		filesindex.splice(j,1);
                    		filesurl.splice(j,1);
                    	}
                    }
                    console.log(filesurl);

                });
            	index+=1;
            });

            //Read the image
            picReader.readAsDataURL(file);

        }

    });
}
else
{
    console.log("Your browser does not support File API");
}
