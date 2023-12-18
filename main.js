const localVideo = document.getElementById('localVideo');
const remoteVideo = document.getElementById('remoteVideo');
const startButton = document.getElementById('startButton');
const callButton = document.getElementById('callButton');
const hangupButton = document.getElementById('hangupButton');
const localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });

let peerConnection;
let isCaller = false;

startButton.addEventListener('click', startCall);
callButton.addEventListener('click', initiateCall);
hangupButton.addEventListener('click', hangUp);

async function startCall() {
  try {
    localVideo.srcObject = localStream;

    peerConnection = new RTCPeerConnection();
    localStream.getTracks().forEach((track) => peerConnection.addTrack(track, localStream));

    peerConnection.ontrack = (event) => {
      remoteVideo.srcObject = event.streams[0];
    };

    isCaller = true;
  } catch (error) {
    console.error('Error starting the call:', error);
  }
}

function initiateCall() {
  if (isCaller) {
    peerConnection.createOffer()
      .then((offer) => peerConnection.setLocalDescription(offer))
      .then(() => {
        // Send offer to the other Raspberry Pi via signaling server
        const offerMessage = {
          type: 'offer',
          sender: 'RaspberryPi1', // Your device identifier
          recipient: 'RaspberryPi2', // Target device identifier
          offer: peerConnection.localDescription,
        };
        sendMessage(offerMessage);
      })
      .catch((error) => console.error('Error creating offer:', error));
  }
}

function hangUp() {
  if (peerConnection) {
    peerConnection.close();
  }
  localVideo.srcObject = null;
  remoteVideo.srcObject = null;
}

function sendMessage(message) {
  // Send JSON message to the signaling server
  const ws = new WebSocket('ws://localhost:8080');
  ws.onopen = () => ws.send(JSON.stringify(message));
}
