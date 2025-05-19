import { Pool } from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const pool = new Pool({
    host:     process.env.DB_HOST,
    port:     process.env.DB_PORT,
    user:     process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
});

export async function connectDatabase() {
    try {
        await pool.query('SELECT 1');
        console.log('PostgreSQL conectado');
    } catch (err) {
        console.error('Erro ao conectar no PostgreSQL:', err);
        process.exit(1);
    }
}

export { pool };
