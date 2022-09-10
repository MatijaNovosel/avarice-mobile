import 'package:freezed_annotation/freezed_annotation.dart';

part 'spendingByTagModel.freezed.dart';
part 'spendingByTagModel.g.dart';

@freezed
class SpendingByTagModel with _$SpendingByTagModel {
  const factory SpendingByTagModel({
    required double amount,
    required String description,
  }) = _SpendingByTagModel;

  factory SpendingByTagModel.fromJson(Map<String, Object?> json) => _$SpendingByTagModelFromJson(json);
}
