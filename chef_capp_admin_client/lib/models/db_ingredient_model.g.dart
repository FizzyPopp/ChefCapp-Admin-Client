// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBIngredientModel _$DBIngredientModelFromJson(Map<String, dynamic> json) {
  return DBIngredientModel(
    json['id'] == null
        ? null
        : IDModel.fromJson(json['id'] as Map<String, dynamic>),
    json['name'] as String,
    json['plural'] as String,
    json['unit'] as Map<String, dynamic>,
    json['category'] as String,
  );
}

Map<String, dynamic> _$DBIngredientModelToJson(DBIngredientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'plural': instance.plural,
      'unit': instance.unit,
      'category': instance.category,
    };
