function getPrevContent(i){
    if(i<=0){
        alert("이전 페이지가 없습니다.");
    }else{
        var prevForm = document.createElement("form");
        prevForm.setAttribute("charset", "UTF-8");
        prevForm.setAttribute("method", "post");
        prevForm.setAttribute("action", "GetLangGamePrevContent");
        document.body.appendChild(prevForm);
        prevForm.submit();
    }
}
function getNextContent(i,questionNum,gameSize){
    if(i>=gameSize-1){
        if(!confirm(questionNum + "번 문항의 게임을 종료하시겠습니까?")){return;}
    }
    var nextForm = document.createElement("form");
    nextForm.setAttribute("charset", "UTF-8");
    nextForm.setAttribute("method", "post");
    nextForm.setAttribute("action", "GetLangGameNextContent");
    document.body.appendChild(nextForm);
    nextForm.submit();
}