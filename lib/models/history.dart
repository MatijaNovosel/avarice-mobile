import 'dart:ui';

class RecentDepositsAndWithdrawals {
  double withdrawals;
  double deposits;

  RecentDepositsAndWithdrawals({
    this.withdrawals,
    this.deposits,
  });
}

class HistoryModel {
  double amount;
  String createdAt;

  HistoryModel({
    this.amount,
    this.createdAt,
  });
}

class TagPercentageModel {
  double percentage;
  String description;
  Color color;

  TagPercentageModel({
    this.percentage,
    this.description,
    this.color,
  });
}

class SpendingByTagModel {
  double amount;
  String description;

  SpendingByTagModel({
    this.amount,
    this.description,
  });
}
