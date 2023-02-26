<%--
  Created by IntelliJ IDEA.
  User: Jiwon Lee
  Date: 2023-02-26
  Time: 오후 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Test Canvas</title>
  <style>
    body {
      background-color: #f6f9fc;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
      Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding-top: 50px;
    }

    .canvas {
      width: 500px;
      height: 500px;
      background-color: white;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
    }
  </style>
</head>
<body>
<canvas id="jsCanvas" class="canvas"></canvas>
<script>
  const canvas = document.getElementById("jsCanvas");
  const ctx = canvas.getContext("2d");

  canvas.width = 500;
  canvas.height = 500;

  ctx.strokeStyle = "black";
  ctx.lineWidth = 2.5;

  let painting = false;

  function startPainting() {
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

  if (canvas) {
    canvas.addEventListener("mousemove", onMouseMove);
    canvas.addEventListener("mousedown", startPainting);
    canvas.addEventListener("mouseup", stopPainting);
    canvas.addEventListener("mouseleave", stopPainting);
  }
</script>
</body>
</html>
