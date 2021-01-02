class PaymentSource {
  double amount;
  String description;
  int id;

  PaymentSource({
    this.amount,
    this.description,
    this.id,
  });

  factory PaymentSource.fromJson(Map<String, dynamic> json) {
    return PaymentSource(
      amount: json['amount'] == null ? 0.0 : json['amount'].toDouble(),
      description: json['description'] as String,
      id: json['id'] as int,
    );
  }
}
