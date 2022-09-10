import 'package:freezed_annotation/freezed_annotation.dart';

part 'historyModel.freezed.dart';
part 'historyModel.g.dart';

@freezed
class HistoryModel with _$HistoryModel {
  const factory HistoryModel({
    required double amount,
    required String createdAt,
  }) = _HistoryModel;

  factory HistoryModel.fromJson(Map<String, Object?> json) => _$HistoryModelFromJson(json);
}
