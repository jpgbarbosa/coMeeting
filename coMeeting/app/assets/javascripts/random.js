function disableEnter(e){
    var key;
    if(window.event)
        key = windows.event.keyCode;
    else
        key = e.which;

    return (key != 13);
}

$(document).ready(function() {
  setTimeout(hideFlashMessages, 4000);
});

function hideFlashMessages() {
  $('div.message').fadeOut(3000)
}