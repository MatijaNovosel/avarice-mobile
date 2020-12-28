class PaymentSource {
  int id;
  double amount;
  String description;
  String icon;

  PaymentSource({
    this.id,
    this.amount,
    this.description,
    this.icon,
  });

  factory PaymentSource.fromJson(Map<String, dynamic> json) {
    return PaymentSource(
      amount: json['amount'] == null ? 0.0 : json['amount'].toDouble(),
      id: json['id'] as int,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}
