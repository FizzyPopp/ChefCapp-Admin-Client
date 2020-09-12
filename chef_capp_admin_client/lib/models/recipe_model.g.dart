// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return RecipeModel(
    json['id'] == null
        ? null
        : IDModel.fromJson(json['id'] as Map<String, dynamic>),
    json['title'] as String,
    json['yield'] as int,
    json['prepTime'] as int,
    json['cookTime'] as int,
    (json['steps'] as List)
        ?.map((e) => e == null
            ? null
            : RecipeStepModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as String,
  );
}

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'yield': instance.yield,
      'prepTime': instance.prepTime,
      'cookTime': instance.cookTime,
      'steps': instance.steps,
      'status': instance.status,
    };
