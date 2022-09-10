import 'package:finapp/models/tag/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required double amount,
    required String createdAt,
    required String description,
    required bool expense,
    required String accountDescription,
    required List<Tag> tags,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, Object?> json) => _$TransactionFromJson(json);
}
