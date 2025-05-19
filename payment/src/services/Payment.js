import { pool } from '../config/postgres.js'
import { channel } from '../config/rabbitmq.js'

const QUEUE = process.env.RABBITMQ_QUEUE || 'notification'

export default class PaymentService {
    async create(paymentObject){
        const { userEmail: user_email, value } = paymentObject || {};

        const result = await pool.query(
            'INSERT INTO payments (user_email, value, status) VALUES ($1, $2, $3) RETURNING *',
            [user_email, value, 'received']
        );

        channel.sendToQueue(QUEUE, Buffer.from(JSON.stringify({
            paymentObject: result.rows[0],
        })));

        this.#processPayment(result.rows[0]);

        return { message: 'Pagamento recebido e sendo processado.' }
    }

    #processPayment(row){
        setTimeout(async () => {
            await pool.query(
                'UPDATE payments SET status = $1 WHERE id = $2',
                ['processed', row.id]
            );

            row.status = 'processed'

            channel.sendToQueue(QUEUE, Buffer.from(JSON.stringify({
                paymentObject: row,
            })));
        }, 5000);
    }
}