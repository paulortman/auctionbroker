import React from 'react'

const HelloWorld = () => {
  return (
    <div className='hello-world'>
      <h1>Hello World</h1>
      <p>Welcome to my world</p>
    </div>
  )
}

export default HelloWorld




















// Note that the path doesn't matter right now; any WebSocket
// connection gets bumped over to WebSocket consumers
socket = new WebSocket("ws://" + window.location.host + "/");
socket.onmessage = function(e) {
    alert(e.data);
};
socket.onopen = function() {
    socket.send("hello world");
};



