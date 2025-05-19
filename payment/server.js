import 'dotenv/config.js';
import { app, init } from './src/app.js';

const PORT = process.env.PORT || 3000;

init().then(() => {
    app.listen(PORT, () => {
        console.log(`Payment server listening at: http://localhost:${PORT}`);
    });
})
