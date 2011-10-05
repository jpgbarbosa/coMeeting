function disableEnter(e){
    var key;
    if(window.event)
        key = windows.event.keyCode;
    else
        key = e.which;

    return (key != 13);
}
