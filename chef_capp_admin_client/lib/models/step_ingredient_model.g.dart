// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepIngredientModel _$StepIngredientModelFromJson(Map<String, dynamic> json) {
  return StepIngredientModel(
    json['id'] == null
        ? null
        : IDModel.fromJson(json['id'] as Map<String, dynamic>),
    json['name'] as String,
    json['verbiage'] as String,
    (json['quantity'] as num)?.toDouble(),
    json['unit'] as String,
  );
}

Map<String, dynamic> _$StepIngredientModelToJson(
        StepIngredientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'verbiage': instance.verbiage,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
