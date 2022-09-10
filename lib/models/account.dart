class Account {
  double amount;
  String description;
  int id;

  Account({
    required this.amount,
    required this.description,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, description: $description, amount: $amount}';
  }
}
