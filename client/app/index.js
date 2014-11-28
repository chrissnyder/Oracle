navigator.webkitGetUserMedia({
    video: true,
    audio: false
  },
  function(localMediaStream){
    var video = document.querySelector('video');
    var canvas = document.querySelector('#the-canvas');
    var context = canvas.getContext('2d');
    video.src = window.URL.createObjectURL(localMediaStream);
    video.play();

    window.s = localMediaStream;
    window.v = video;

    var client = BinaryClient('ws://localhost:9000');
    client.on('open', function() {
      console.log('connection opened');

      setInterval(function() {
        context.drawImage(video, 0, 0, 640, 480, 0, 0, 640, 480);
        frameUri = canvas.toDataURL();
        console.log(frameUri);
        var stream = client.send(frameUri);
      }, 3000);
    });

    client.on('error', function(error) {
      console.log(error);
    });
  },
  function(err){
    console.log('didnt work :-(');
    console.log(err);
  }
);
  