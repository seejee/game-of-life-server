$(function() {
  var socket = new Phoenix.Socket("/ws");
  socket.connect();

  var CELL_SIZE = 4;
  var first = true;
  var lastLoop = new Date;

  var drawBoard = function(data) {
    var $canvas = $('#game');

    if(first) {
      $canvas.attr({width: data.width * CELL_SIZE, height: data.height * CELL_SIZE});
      first = false
    }

    var thisLoop = new Date;
    var fps = 1000 / (thisLoop - lastLoop);
    lastLoop = thisLoop;
    //console.log("FPS: " + fps);

    var c = $canvas[0];
    var ctx = c.getContext("2d");
    ctx.clearRect(0, 0, c.width, c.height );
    ctx.fillStyle = "#000000";

    _.each(data.cells, function(cell) {
      ctx.fillRect(cell[0] * CELL_SIZE, cell[1] * CELL_SIZE, CELL_SIZE, CELL_SIZE);
    });
  };

  var channel = socket.chan("game:global", {});

  channel.on("game:data", function(data) {
    drawBoard(data);
  });

  channel.join().receive("ok", function() {
  });
});
