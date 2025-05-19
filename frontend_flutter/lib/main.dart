import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'services/notification_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final service = NotificationService();
        service.connect();
        return service;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompreFácil Pagamento',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const PaymentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
