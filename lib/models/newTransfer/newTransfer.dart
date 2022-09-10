import 'package:freezed_annotation/freezed_annotation.dart';

part 'newTransfer.freezed.dart';
part 'newTransfer.g.dart';

@freezed
class NewTransfer with _$NewTransfer {
  const factory NewTransfer({
    required int accountFromId,
    required int accountToId,
    required double amount,
  }) = _NewTransfer;

  factory NewTransfer.fromJson(Map<String, Object?> json) => _$NewTransferFromJson(json);
}
