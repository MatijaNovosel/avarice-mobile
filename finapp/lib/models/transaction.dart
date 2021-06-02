import 'package:finapp/models/tag.dart';

class Transaction {
  int id;
  double amount;
  String createdAt;
  String description;
  bool expense;
  String accountDescription;
  List<Tag> tags;

  @override
  String toString() {
    return '{amount: ${this.amount}, createdAt: ${this.createdAt}, description: ${this.description}}';
  }

  Transaction({
    this.id,
    this.amount,
    this.createdAt,
    this.description,
    this.expense,
    this.accountDescription,
    this.tags,
  });
}
