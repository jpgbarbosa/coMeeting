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

function sendEmail(participation_id){
	$.ajax({
	  type    : "POST",
	  url     : "/participations/send_email",
	  data    : { authenticity_token: $('meta[name="csrf-token"]').attr('content'), id: participation_id },
	});
	$("a#email_image_"+participation_id).slideUp(1000);
}


// idle.js (c) Alexios Chouchoulas 2009
// Released under the terms of the GNU Public License version 2.0 (or later).
  
var _idleTimeout = 5000;	// 5 seconds
 
var _idleNow = false;
var _idleTimestamp = null;
var _idleTimer = null;
 
function setIdleTimeout(ms){
    _idleTimeout = ms;
    _idleTimestamp = new Date().getTime() + ms;
    if (_idleTimer != null) {
		clearTimeout (_idleTimer);
    }
    _idleTimer = setTimeout(_makeIdle, ms + 50);
    //alert('idle in ' + ms + ', tid = ' + _idleTimer);
}
 
function _makeIdle(){
    var t = new Date().getTime();
    if (t < _idleTimestamp) {
		//alert('Not idle yet. Idle in ' + (_idleTimestamp - t + 50));
		_idleTimer = setTimeout(_makeIdle, _idleTimestamp - t + 50);
		return;
    }
    //alert('** IDLE **');
    _idleNow = true;
	updateMinutes($("input#token").val());
}




 
function _active(event){
    var t = new Date().getTime();
    _idleTimestamp = t + _idleTimeout;
    //alert('not idle.');
 
	if(_idleNow){
		setIdleTimeout(_idleTimeout);
	}
     
    try {
		//alert('** BACK **');
		if ((_idleNow ) && document.onBack){
			//document.onBack(_idleNow);
		}
    } catch (err) {
    }
 
    _idleNow = false;
}
 
function _initJQuery(){
    var doc = $(document);
    doc.ready(function(){
            try {
                doc.keydown(_active);
            } catch (err) { }
        });
}






