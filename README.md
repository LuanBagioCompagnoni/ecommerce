# Sistema de Pagamentos com Notificações

Este projeto é um sistema de pagamentos assíncrono que utiliza:

- Flutter (App mobile)
- Microsserviços em Node.js:
  - Serviço de **pagamento**
  - Serviço de **notificação**
- RabbitMQ (mensageria)
- Postgres (banco de dados)
- WebSocket para notificações em tempo real

---

## 📱 Aplicativo Flutter

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio ou emulador / dispositivo físico

# Como rodar o back-end (microsserviços)

### Na raiz do projeto (onde está o docker-compose.yml)

### 1. Build dos serviços
```bash
docker-compose build
```

### 2. Subir os containers
```bash
docker-compose up -d
```

# Como rodar o app

### 1. Navegue até a pasta do app Flutter
```bash
cd frontend_flutter
```

### 2. Instale as dependências
```bash
flutter pub get
```

### 3. Rode o app em um emulador ou dispositivo
```bash
flutter run
```
