
function addElement() {
    var div = document.getElementById('theValue');
	var ni = document.getElementById('myDiv');
	var numi = document.getElementById('theValue');
	var num = (div.value - 1) + 1;
	numi.value = num;
	var newdiv = document.createElement('div');
	var divIdName = 'my' + num + 'Div';
	newdiv.setAttribute('id', divIdName);

	newdiv.innerHTML = "<input class='topic' type='text' size='30' name ='topics_" + num + "' id='field_" + num + "'>  <a href='#' onclick='removeElement(" + divIdName + "); return false; '> <img valign='top' alt='Cross' src='/assets/icons/cross.png'> </a><p></p>";
	ni.appendChild(newdiv);

    div.value = num + 1;
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
    var meeting_id = parts[5];
    newDiv.innerHTML = "<form accept-charset='UTF-8' action='/en/participations' class='form' id='create_participation_"+ num + "' method='post'>" +
        "<input type='hidden' name='meeting_id' value='" + meeting_id + "'/>" +
        "<input class='person' type='text' size='30' name ='person' id='field'>  <a href='#' onclick='removePerson(" + divName + "); return false;'> <img valign='top' alt='Cross' src='/assets/icons/cross.png'> </a>" +
        "<a href='#' > <img valign='top' src='/assets/icons/email_go.png' onclick='createParticipation("+num +"); return false; '> </a><p></p>" +
        "</form>";

    myDiv.appendChild(newDiv);

    document.getElementById(divName).scrollIntoView();

}

function removePerson(divNum){
    var div = document.getElementById('myDiv');
    var oldDiv = document.getElementById(divNum.id);

    div.removeChild(oldDiv);
}


function createParticipation(num){
    var name = 'create_participation_' + num;
    document.forms[name].submit();
}
