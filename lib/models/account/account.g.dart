// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'id': instance.id,
    };
