navigator.webkitGetUserMedia({
    video: true,
    audio: false
  },
  function(localMediaStream){
    var video = document.querySelector('video');
    video.src = window.URL.createObjectURL(localMediaStream);
    video.play()
  },
  function(err){
    console.log('didnt work :-(');
    console.log(err);
  }
);
