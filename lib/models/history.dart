import 'dart:ui';

class RecentDepositsAndWithdrawals {
  double withdrawals;
  double deposits;

  RecentDepositsAndWithdrawals({
    required this.withdrawals,
    required this.deposits,
  });
}

class HistoryModel {
  double amount;
  String createdAt;

  HistoryModel({
    required this.amount,
    required this.createdAt,
  });
}

class TagPercentageModel {
  double percentage;
  String description;
  Color color;

  TagPercentageModel({
    required this.percentage,
    required this.description,
    required this.color,
  });
}

class SpendingByTagModel {
  double amount;
  String description;

  SpendingByTagModel({
    required this.amount,
    required this.description,
  });
}
