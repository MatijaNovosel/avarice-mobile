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
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.description,
    required this.expense,
    required this.accountDescription,
    required this.tags,
  });
}

class NewTransaction {
  double amount;
  String description;
  bool expense;
  int accountId;
  List<int> tags;

  NewTransaction({
    required this.amount,
    required this.description,
    required this.expense,
    required this.accountId,
    required this.tags,
  });
}

class NewTransfer {
  int accountFromId;
  int accountToId;
  double amount;

  NewTransfer({
    required this.amount,
    required this.accountFromId,
    required this.accountToId,
  });
}
