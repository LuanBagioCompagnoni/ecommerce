import express from 'express';
import routes from './routes/index.js';
import cors from 'cors';

import { connectDatabase } from './config/postgres.js';
import { connectRabbitMQ } from './config/rabbitmq.js';

const app = express();

app.use(cors());

routes(app);

async function init() {
    await connectRabbitMQ();
    await connectDatabase();
}

export { app, init };
