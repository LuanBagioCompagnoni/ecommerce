import amqp from 'amqplib';
import dotenv from 'dotenv';
dotenv.config();

let channel;
const QUEUE = 'notification';

export async function connectRabbitMQ(retries = 5, delay = 5000) {
  const url = process.env.RABBITMQ_URL || 'amqp://guest:guest@rabbitmq';

  for (let i = 0; i < retries; i++) {
    try {
      const connection = await amqp.connect(url);
      channel = await connection.createChannel();
      await channel.assertQueue(QUEUE);
      console.log('RabbitMQ conectado');
      return;
    } catch (err) {
      console.log(`RabbitMQ indisponível, nova tentativa em ${delay} ms… (${i + 1}/${retries})`);
      await new Promise(r => setTimeout(r, delay));
    }
  }

  console.error('Não foi possível conectar ao RabbitMQ; abortando.');
  process.exit(1);
}

export { channel };
