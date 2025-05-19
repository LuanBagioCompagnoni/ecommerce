import { Server as SocketIO } from 'socket.io';

let io;

const initSocket = (server) => {
    io = new SocketIO(server, {
        cors: {
            origin: '*',
            methods: ['GET', 'POST'],
        },
    });
    io.use((socket, next) => {
        console.log('🆕  Client connected:', socket.id);
        next();
    });

    io.on('connection', (socket) => {
        socket.on('disconnect', () => {
            console.log('👋  Client disconnected:', socket.id);
        });
    });
};

export { initSocket, io };
