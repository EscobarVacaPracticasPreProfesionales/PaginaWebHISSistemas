var elements=document.getElementsByClassName("carousel-inner")
for (var i = 0; i<elements.length; i++) {
	elements[i].childNodes[1].className+=" active";
}

var elements=document.getElementsByClassName("carousel-indicators")
for (var i = 0; i<elements.length; i++) {
	elements[i].childNodes[1].className+=" active";
}