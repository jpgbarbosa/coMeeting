
function addTopic() {
    var numberDiv = document.getElementById('currentNumber');
	var mainDiv = document.getElementById("topicsDiv");
	var num = (numberDiv.value - 1) + 1;
	var divIdName = "topic" + num;
	var newDiv = document.createElement("div");
	newDiv.setAttribute("id", divIdName);

	newDiv.innerHTML = "<input class='topic' id='meeting_topics' name='meeting[topics][]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeTopic(" + divIdName + ");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a><p></p>";
	mainDiv.appendChild(newDiv);

    numberDiv.value = num + 1;
	window.scrollBy(0, 42); // horizontal and vertical scroll increments
}

function removeTopic(divNum) {

	var mainDiv = document.getElementById('topicsDiv');
	var olddiv = document.getElementById(divNum.id);
	if(mainDiv.childElementCount > 3){
		mainDiv.removeChild(olddiv);
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
        "<input class='person' type='text' size='30' name ='person' id='field'>  <a href='#' tabindex='-1' onclick='removePerson(" + divName + ");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>" +
        "<a href='#' tabindex='-1' onclick='createParticipation("+num +");return false;'> <img valign='top' src='/assets/icons/email_go.png'> </a><p></p>" +
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
