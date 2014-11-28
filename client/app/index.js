navigator.webkitGetUserMedia(
  {
    video: true,
    audio: true
  },
  function(localMediaStream){
    var video = document.querySelector('video');
    video.src = window.URL.createObjectURL(localMediaStream);
  },
  function(err){
    console.log('didnt work :-(');
    console.log(err);
  }
)
