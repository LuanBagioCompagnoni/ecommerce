import express from 'express';
import PaymentController from '../controllers/Payment.js';
const paymentController = new PaymentController();

const router = express.Router();

router.post('/', paymentController.create.bind(paymentController));

export default router;
