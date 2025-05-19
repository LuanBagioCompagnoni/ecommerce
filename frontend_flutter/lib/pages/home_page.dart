import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../models/payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  double _amount = 0.0;
  PaymentTransaction? _transaction;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final notificationService =
    Provider.of<NotificationService>(context, listen: false);

    notificationService.addListener(() {
      final message = notificationService.lastMessage;
      if (message != null) {
        _handleNotification(message);
      }
    });
  }

  void _handleNotification(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      final transaction = await ApiService.enviarPagamento(
        _email,
        _amount,
      );

      if (transaction != null) {
        setState(() => _transaction = transaction);
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagamento")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) =>
                  value!.isEmpty ? 'Obrigatório' : null,
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (value) =>
                  value!.isEmpty ? 'Obrigatório' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? 'Obrigatório' : null,
                  onSaved: (value) => _amount = double.parse(value!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Pagar"),
                )
              ]),
            ),
            const SizedBox(height: 20),
            if (_transaction != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Transação: ${_transaction!.id}'),
                  Text('Status: ${_transaction!.status}'),
                ],
              )
          ],
        ),
      ),
    );
  }
}
