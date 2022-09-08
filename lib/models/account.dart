class Account {
  double amount;
  String description;
  int id;

  Account({
    this.amount,
    this.description,
    this.id,
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
