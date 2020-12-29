class PaymentSource {
  double amount;
  String description;

  PaymentSource({
    this.amount,
    this.description,
  });

  factory PaymentSource.fromJson(Map<String, dynamic> json) {
    return PaymentSource(
      amount: json['amount'] == null ? 0.0 : json['amount'].toDouble(),
      description: json['description'] as String,
    );
  }
}
