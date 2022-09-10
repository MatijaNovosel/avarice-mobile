import 'package:freezed_annotation/freezed_annotation.dart';

part 'newTransaction.freezed.dart';
part 'newTransaction.g.dart';

@freezed
class NewTransaction with _$NewTransaction {
  const factory NewTransaction({
    required double amount,
    required String description,
    required bool expense,
    required int accountId,
    required List<int> tags,
  }) = _NewTransaction;

  factory NewTransaction.fromJson(Map<String, Object?> json) => _$NewTransactionFromJson(json);
}
