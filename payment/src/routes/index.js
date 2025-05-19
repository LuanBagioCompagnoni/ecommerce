import express from 'express';
import paymentRoutes from './payment.js';

const routes = (app) => {
    app.use(express.json());
    app.use('/payment', paymentRoutes);
    app.use('/', (req, res) => {
        res.send('Welcome!');
    })
};

export default routes;
