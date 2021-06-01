class Transaction {
  int id;
  double amount;
  String createdAt;
  String description;
  bool expense;
  int paymentSourceId;
  int appUserId;
  List<int> tagIds;

  @override
  String toString() {
    return '{amount: ${this.amount}, createdAt: ${this.createdAt}, description: ${this.description}}';
  }

  Transaction(
      {this.id,
      this.amount,
      this.createdAt,
      this.description,
      this.expense,
      this.paymentSourceId,
      this.appUserId,
      this.tagIds});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        amount: json['amount'] == null ? 0.0 : json['amount'].toDouble(),
        appUserId: json['appUserId'] as int,
        createdAt: json['createdAt'] as String,
        description: json['description'] as String,
        expense: json['expense'] as bool,
        id: json['id'] as int,
        paymentSourceId: json['paymentSourceId'] as int,
        tagIds: json['tagIds'].cast<int>());
  }
}
