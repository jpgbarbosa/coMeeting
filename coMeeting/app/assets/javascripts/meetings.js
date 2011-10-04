	function addElement() {
        var ni = document.getElementById('myDiv');
        var numi = document.getElementById('theValue');
        var num = (document.getElementById('theValue').value - 1) + 2;
        numi.value = num;
        var newdiv = document.createElement('div');
        var divIdName = 'my' + num + 'Div';
        newdiv.setAttribute('id', divIdName);

        newdiv.innerHTML = '<input type=\'text\' size=\'30\' id=\'field ' + num + '\' + ">  <a href=\'#\' onclick=\'removeElement(' + divIdName + ')\'> - </a>';
        ni.appendChild(newdiv);

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