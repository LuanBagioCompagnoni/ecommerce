import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

class NotificationService extends ChangeNotifier {
  late IO.Socket socket;
  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  void connect() {
    final wsUrl = dotenv.env['WEBSOCKET_URL'];
    if (wsUrl == null) throw Exception('WEBSOCKET_URL não definido no .env');

    socket = IO.io(wsUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      debugPrint('Socket.IO connected');
    });

    socket.on('notification', (data) {
      if (data is Map && data['message'] != null) {
        _lastMessage = data['message'].toString();
        notifyListeners();
      }
    });

    socket.onDisconnect((_) {
      debugPrint('Socket.IO disconnected');
    });

    socket.onError((error) {
      debugPrint('Socket.IO error: $error');
    });

    socket.connect();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
