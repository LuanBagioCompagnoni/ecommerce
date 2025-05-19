class PaymentTransaction {
  final String id;
  final String email;
  final double amount;
  final String status;
  final DateTime createdAt;

  PaymentTransaction({
    required this.id,
    required this.email,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'].toString(),
      email: json['user_email'],
      amount: double.tryParse(json['value'].toString()) ?? 0.0,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_email': email,
    'value': amount.toString(),
  };

  PaymentTransaction copyWith({
    String? id,
    String? email,
    double? amount,
    String? status,
    DateTime? createdAt,
  }) {
    return PaymentTransaction(
      id: id ?? this.id,
      email: email ?? this.email,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
