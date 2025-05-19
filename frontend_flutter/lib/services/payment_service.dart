import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/payment.dart';

class PaymentService {
  static late final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000';

  static Future<PaymentTransaction?> sendTransaction({
    required String name,
    required String email,
    required double amount,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'amount': amount,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return PaymentTransaction.fromJson(jsonDecode(response.body));
    } else {
      print('Erro: ${response.body}');
      return null;
    }
  }

  static Future<PaymentTransaction?> getTransactionStatus(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/payments/$id'));

    if (response.statusCode == 200) {
      return PaymentTransaction.fromJson(jsonDecode(response.body));
    } else {
      print('Erro ao obter status: ${response.body}');
      return null;
    }
  }
}
