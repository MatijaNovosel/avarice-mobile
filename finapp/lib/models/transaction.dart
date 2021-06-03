import 'package:finapp/models/tag.dart';

class Transaction {
  int id;
  double amount;
  String createdAt;
  String description;
  bool expense;
  String accountDescription;
  List<Tag> tags;

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

class NewTransaction {
  double amount;
  String createdAt;
  String description;
  bool expense;
  int accountId;
  List<int> tags;

  NewTransaction({
    this.amount,
    this.createdAt,
    this.description,
    this.expense,
    this.accountId,
    this.tags,
  });
}
