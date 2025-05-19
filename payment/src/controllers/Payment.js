import PaymentService from "../services/Payment.js";

export default class PaymentController{

    constructor() {
        this.paymentService = new PaymentService();
    }

    async create(req,res){
        try {
            const result = await this.paymentService.create(req.body);
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json({ message: 'Erro ao criar pagamento', error: err.message });
        }
    }

}