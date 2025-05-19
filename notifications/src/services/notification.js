import { io } from '../socket.js';

export default class NotificationService {
    sendAppNotification(data) {
        io.emit('notification', data);
    }
}
