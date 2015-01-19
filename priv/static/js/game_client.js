$(function() {
  var socket = new Phoenix.Socket("/ws");

  var CELL_SIZE = 3;
  var first = true;
  var lastLoop = new Date;

  var drawBoard = function(data) {
    $canvas = $('#game');

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
      ctx.fillRect(cell[0] * CELL_SIZE, cell[1] * CELL_SIZE,CELL_SIZE,CELL_SIZE);
    });
  };

  socket.join("game:global", {}, function(channel) {
    channel.on("game:data", function(data) {
      drawBoard(data);
    });
  });
});
