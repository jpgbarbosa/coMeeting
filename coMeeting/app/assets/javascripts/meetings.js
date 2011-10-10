function addElement() {
	var ni = document.getElementById('myDiv');
	var numi = document.getElementById('theValue');
	var num = (document.getElementById('theValue').value - 1) + 2;
	numi.value = num;
	var newdiv = document.createElement('div');
	var divIdName = 'my' + num + 'Div';
	newdiv.setAttribute('id', divIdName);

	newdiv.innerHTML = '<input class=\'topic\' type=\'text\' size=\'30\' name =\'topics_' + num + '\' id=\'field_' + num + '\'>  <a href=\'#\' onclick=\'return removeElement(' + divIdName + ');\'> <img valign=\'top\' alt=\'Cross\' src=\'/assets/cross.png\'> </a><p></p>';
	ni.appendChild(newdiv);

	window.scrollBy(0,42); // horizontal and vertical scroll increments

	return false;
}

function removeElement(divNum) {

	var d = document.getElementById('myDiv');
	var olddiv = document.getElementById(divNum.id);
	if(d.childElementCount > 3){
		d.removeChild(olddiv);
	}
	else{
		olddiv.children[0].value ="";
	}
	return false;
}
