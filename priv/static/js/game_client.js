var socket = new Phoenix.Socket("/ws");

socket.join("game:global", {}, function(channel) {
  console.log('joined');
  channel.on("game:data", function(data) {
    console.log(data);
  });
});

