import express from 'express';
import http from 'node:http';
import { connectRabbitMQ } from './src/config/rabbitmq.js';
import { initSocket } from './src/socket.js';
import startConsume from './src/consumers/notification.js';

const app = express();
const server = http.createServer(app);

const channel = await connectRabbitMQ();
startConsume(channel).catch(err => {
  console.error('Error on init consumers:', err);
});

initSocket(server);

const PORT = process.env.PORT || 4000;
server.listen(PORT, () => {
  console.log(`Notification socket server running on ${PORT}`);
});
