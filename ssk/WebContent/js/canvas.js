const canvas = document.getElementById("jsCanvas");
const ctx = canvas.getContext("2d");

var clientWidth = document.getElementById('canvas-container').clientWidth;//실제 너비 받아오기
var clientHeight = document.getElementById('canvas-container').clientHeight;

canvas.width = clientWidth;
canvas.height = clientHeight;

ctx.strokeStyle = "black";
ctx.lineWidth = 2.5;

let painting = false;


function startPainting(event) {
    painting=true;
}
function stopPainting(event) {
    painting=false;
}

function onMouseMove(event) {
    const x = event.offsetX;
    const y = event.offsetY;
    if(!painting) {
        ctx.beginPath();
        ctx.moveTo(x, y);
    }
    else {
        ctx.lineTo(x, y);
        ctx.stroke();
    }
}
function onTouchMove(event) {
    event.preventDefault();
    const x = event.targetTouches[0].pageX;
    const y = event.targetTouches[0].pageY;
    if(!painting) {
        ctx.beginPath();
        ctx.moveTo(x, y);
    }
    else {
        ctx.lineTo(x, y);
        ctx.stroke();
    }
}

if (canvas) {
    canvas.addEventListener("mousemove", onMouseMove);
    canvas.addEventListener("mousedown", startPainting);
    canvas.addEventListener("mouseup", stopPainting);
    canvas.addEventListener("mouseleave", stopPainting);
    canvas.addEventListener("touchstart", startPainting, false);
    canvas.addEventListener("touchmove", onTouchMove, false);
    canvas.addEventListener("touchend", stopPainting, false);
    canvas.addEventListener("touchcancel", stopPainting, false);
}

function removePainting(){
    // 픽셀 정리
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    // 컨텍스트 리셋
    ctx.beginPath();
}
