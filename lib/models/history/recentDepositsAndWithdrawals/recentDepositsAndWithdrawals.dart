import 'package:freezed_annotation/freezed_annotation.dart';

part 'recentDepositsAndWithdrawals.freezed.dart';
part 'recentDepositsAndWithdrawals.g.dart';

@freezed
class RecentDepositsAndWithdrawals with _$RecentDepositsAndWithdrawals {
  const factory RecentDepositsAndWithdrawals({
    required double withdrawals,
    required double deposits,
  }) = _RecentDepositsAndWithdrawals;

  factory RecentDepositsAndWithdrawals.fromJson(Map<String, Object?> json) => _$RecentDepositsAndWithdrawalsFromJson(json);
}
