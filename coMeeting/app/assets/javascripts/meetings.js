function setValue(num){
    document.getElementById('theValue').value = num;
}


function addElement() {
	var ni = document.getElementById('myDiv');
	var numi = document.getElementById('theValue');
	var num = (document.getElementById('theValue').value - 1) + 2;
	numi.value = num;
	var newdiv = document.createElement('div');
	var divIdName = 'my' + num + 'Div';
	newdiv.setAttribute('id', divIdName);

	newdiv.innerHTML = '<input class=\'topic\' type=\'text\' size=\'30\' name =\'topics_' + num + '\' id=\'field_' + num + '\'>  <a href=\'#\' onclick=\'removeElement(' + divIdName + '); return false;\'> <img valign=\'top\' alt=\'Cross\' src=\'/assets/icons/cross.png\'> </a><p></p>';
	ni.appendChild(newdiv);

	window.scrollBy(0,42); // horizontal and vertical scroll increments
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
}

function addPerson(){
    var myDiv = document.getElementById('myDiv');
    var val = document.getElementById('theValue');
    var num = (val.value - 1) + 2;
    val.value = num;

    var newDiv = document.createElement('div');
    var divName = 'my' + num + 'Div';
    newDiv.setAttribute('id',divName);
    var url = document.location.href;
    var parts = url.split('/');
    newDiv.innerHTML = '<input class=\'person\' type=\'text\' size=\'30\' name =\'person_' + num + '\' id=\'field_' + divName + '\'>  <a href=\'#\' onclick=\'removePerson(' + divName + '); return false;\'> <img valign=\'top\' alt=\'Cross\' src=\'/assets/icons/cross.png\'> </a><a href=\'/en/participations/create/'+ parts[5] + '\' > <img valign=\'top\' src=\'/assets/icons/tick.png\'> </a><p></p>';
    myDiv.appendChild(newDiv);

    window.scrollTo(0,newDiv.value);
}

function removePerson(divNum){
    var div = document.getElementById('myDiv');
    var oldDiv = document.getElementById(divNum.id);

    div.removeChild(oldDiv);
}
