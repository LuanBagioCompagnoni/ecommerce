import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/payment.dart';

class ApiService {
  static final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000';

  static Future<PaymentTransaction?> enviarPagamento(String usuario, double valor) async {
    final url = Uri.parse('$baseUrl/payment');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_email': usuario, 'value': valor}),
    );

    if (response.statusCode == 202) {
      final json = jsonDecode(response.body);
      return PaymentTransaction.fromJson(json);
    }

    return null;
  }
}
