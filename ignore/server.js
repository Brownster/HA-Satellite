const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

const clients = {};

wss.on('connection', (ws) => {
  console.log('New connection established');

  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);
      const { type, sender, recipient, offer, answer, iceCandidate } = data;

      if (type === 'register') {
        clients[sender] = ws;
        console.log(`Registered client: ${sender}`);
      } else if (type === 'call') {
        const target = clients[recipient];
        if (target) {
          target.send(JSON.stringify({ type: 'incomingCall', sender }));
        }
      } else if (type === 'offer') {
        const target = clients[recipient];
        if (target) {
          target.send(JSON.stringify({ type: 'offer', sender, offer }));
        }
      } else if (type === 'answer') {
        const target = clients[sender];
        if (target) {
          target.send(JSON.stringify({ type: 'answer', answer }));
        }
      } else if (type === 'iceCandidate') {
        const target = clients[recipient];
        if (target) {
          target.send(JSON.stringify({ type: 'iceCandidate', sender, iceCandidate }));
        }
      }
    } catch (error) {
      console.error('Error parsing message:', error);
    }
  });

  ws.on('close', () => {
    console.log('Connection closed');
  });
});

console.log('Signaling server is running on ws://localhost:8080');
