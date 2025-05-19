import NotificationService from '../services/notification.js';
const notificationService = new NotificationService();

export default async function startConsume(channel) {
    const QUEUE = process.env.RABBITMQ_QUEUE || 'notification';

    channel.consume(QUEUE, (msg) => {
        if (msg !== null) {
            const content = JSON.parse(msg.content.toString());
            console.log('nova mensagem', content);

            if (content.paymentObject.status === 'received') {
                const notificationData = {
                    message: `Recebido pagamento ID ${content.paymentObject.id}, espere pelo processamento!\nValor: ${content.paymentObject.value}`
                }

                notificationService.sendAppNotification(notificationData);
            }

            if (content.paymentObject.status === 'processed') {
                const notificationData = {
                    message: `Pagamento ID ${content.paymentObject.id} foi processado com sucesso!\nValor: ${content.paymentObject.value}`
                }

                notificationService.sendAppNotification(notificationData);
            }

            channel.ack(msg);
        }
    });

    console.log('Consumidor iniciado e aguardando mensagens...');
}
