function addTopic() {
    var numberDiv = document.getElementById('newTopicNumber');
	var mainDiv = document.getElementById("topicsDiv");
	var num = parseInt(numberDiv.value);
	var divName = 'topic' + num;
	var newDiv = document.createElement('div');
	newDiv.setAttribute('id', divName);

	newDiv.innerHTML = "<input class='shorter text_field' id='meeting_topic_" + num + "' name='meeting[topics][]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeTopic(\"" + divName + "\");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>";
	mainDiv.appendChild(newDiv);

    numberDiv.value = num + 1;
	window.scrollBy(0,30);
}


function removeTopic(divNum) {

	var mainDiv = document.getElementById('topicsDiv');
	var oldDiv = document.getElementById(divNum);
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
	var num = parseInt(numberDiv.value);
	var divName = 'participant' + num;
	var newDiv = document.createElement('div');
	newDiv.setAttribute('id', divName);

	if($("input#admin_email").val() == ""){	
		alert('nao tem admin');
		newDiv.innerHTML = "<input class='shorter text_field' id='meeting_participant_" + num + "' name='participations[]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeParticipant(\"" + divName + "\");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>";
	}
	else{
		newDiv.innerHTML = "<input onclick='getCircles();return false;' class='auto_search_complete shorter text_field' id='meeting_participant_" + num + "' name='participations[]' size='30' type='text'>  <a href='#' tabindex='-1' onclick='removeParticipant(\"" + divName + "\");return false;'> <img valign='top' alt='' src='/assets/icons/cross.png'> </a>";
	}
	mainDiv.appendChild(newDiv);

    numberDiv.value = num + 1;
	window.scrollBy(0,30);
}


function removeParticipant(divNum) {

	var mainDiv = document.getElementById('participantsDiv');
	var oldDiv = document.getElementById(divNum);
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
        "<a href='#' tabindex='-1' onclick='createParticipation("+num+");return false;'> <img valign='top' alt='' src='/assets/icons/email.png'> </a><p></p>" +
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
	
	$('textarea#static_minutes').autoResize({
				maxHeight: 1000,
				minHeight: 50
											});
	$.ajax({
	  type    : "POST",
	  url     : "/meetings/update_action_item",
	  data    : { authenticity_token: $('meta[name="csrf-token"]').attr('content'), id: id, action_item: action, deadline: date },
	});
}


jQuery(document).ready(function () {

     $("#minutes").tabby();

});


function updateMinutes(meeting_id) {
	$.ajax({
	  type    : "POST",
	  url     : "/meetings/update_minutes",
	  data    : { authenticity_token: $('meta[name="csrf-token"]').attr('content'), id: meeting_id, minutes: $('#minutes').val() },
	});
}


function getMinutes(meeting_id) {
	$.ajax({
	  type    : "GET",
	  url     : "/meetings/get_minutes",
	  data    : { id: meeting_id },
	});
}

function getCircles(){
	var admin = $("input#admin_email").val();
	$('.auto_search_complete').autocomplete({
			minLength: 1,
			delay: 600,
			source: function(request, response) {
				$.ajax({
					type: "GET",
					url: "/meetings/get_admin_circles.js",
					dataType: "text",
					data: {term: request.term, mail: admin, authenticity_token: $('meta[name="csrf-token"]').attr('content'),},
					success: function( data ) {
						var res = data.split(",");
						response( res);
					}
				});
			}          
		});
}

