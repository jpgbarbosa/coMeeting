function addTopic() {
    var numberDiv = document.getElementById('newTopicNumber');
	var mainDiv = document.getElementById("topicsDiv");
	var num = (numberDiv.value - 1) + 1;
	var divName = 'topic' + num;
	var newDiv = document.createElement('div');
	newDiv.setAttribute('id', divName);

	newDiv.innerHTML = "<input class='shorter text_field' id='meeting_topics' name='meeting[topics][]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeTopic(" + divName + ");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>";
	mainDiv.appendChild(newDiv);

    numberDiv.value = num + 1;
	document.getElementById(divName).scrollIntoView();
}


function removeTopic(divNum) {

	var mainDiv = document.getElementById('topicsDiv');
	var oldDiv = document.getElementById(divNum.id);
	if(mainDiv.childElementCount > 2){
		mainDiv.removeChild(oldDiv);
	}
	else{
		oldDiv.children[0].value ='';
	}
}


function addParticipant() {
    var numberDiv = document.getElementById('newParticipantNumber');
	var mainDiv = document.getElementById("participantsDiv");
	var num = (numberDiv.value - 1) + 1;
	var divName = 'participant' + num;
	var newDiv = document.createElement('div');
	newDiv.setAttribute('id', divName);

	newDiv.innerHTML = "<input class='shorter text_field' id='meeting_participants' name='participations[]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeParticipant(" + divName + ");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>";
	mainDiv.appendChild(newDiv);

    numberDiv.value = num + 1;
	document.getElementById(divName).scrollIntoView();
}


function removeParticipant(divNum) {

	var mainDiv = document.getElementById('participantsDiv');
	var oldDiv = document.getElementById(divNum.id);
	if(mainDiv.childElementCount > 2){
		mainDiv.removeChild(oldDiv);
	}
	else{
		oldDiv.children[0].value ='';
	}
}


function addPerson(){
    var numberDiv = document.getElementById('newParticipantNumber');
	var mainDiv = document.getElementById('participantsDiv');
    var num = (numberDiv.value - 1) + 1;
	var divName = 'participant' + num;
    var newDiv = document.createElement('div');
    newDiv.setAttribute('id', divName);
	
	var meeting_id = document.getElementById('token').value;
	
    newDiv.innerHTML = "<form accept-charset='UTF-8' action='/en/participations' class='form' id='create_participation_"+ num + "' method='post'>" +
        "<input type='hidden' name='meeting_id' value='" + meeting_id + "'/>" +
        "<input class='person' type='text' size='30' name ='person' id='field'>  <a href='#' tabindex='-1' onclick='removePerson(" + divName + ");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>" +
        "<a href='#' tabindex='-1' onclick='createParticipation("+num+");return false;'> <img valign='top' alt='' src='/assets/icons/email_go.png'> </a><p></p>" +
        "</form>";
    mainDiv.appendChild(newDiv);

	numberDiv.value = num + 1;
    document.getElementById(divName).scrollIntoView();
}


function removePerson(divNum){
    var mainDiv = document.getElementById('participantsDiv');
    var oldDiv = document.getElementById(divNum.id);

    mainDiv.removeChild(oldDiv);
}


function createParticipation(num){
    var name = 'create_participation_' + num;
    document.forms[name].submit();
}


function showAction(participant){
	$("tr#"+participant).toggle();
	
}


function addActionItem(participant, id, email){
	var action = $("tr#"+ participant + " td input#item").val();
	var date = $("tr#"+ participant + " input#date").val();
	
	var act = $("#minutes").val();
	
	$("#minutes").val(act + "\n\t\t" + email + '\t' + action + "\t" + date);
}


jQuery(document).ready(function () {

     $("#minutes").tabby();

});

function updateMinutes() {
	var minutes = document.getElementById("minutes");
	$.ajax({
	  type    : "POST",
	  url     : "/meetings/update_minutes",
	  data    : { minutes : minutes.value },
	});
}