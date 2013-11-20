function submitStop(e){
    if (!e) var e = window.event;
 
    if(e.keyCode == 13)
        return false;
}

window.onload = function (){
        var list = document.getElementsByTagName("input");
        for(var i=0; i<list.length; i++){
        if(list[i].type == 'text' || list[i].type == 'password'){
            list[i].onkeypress = function (event){
                return submitStop(event);
            };
        }
    }
}