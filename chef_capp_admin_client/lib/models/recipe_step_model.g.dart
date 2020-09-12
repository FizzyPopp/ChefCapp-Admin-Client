// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeStepModel _$RecipeStepModelFromJson(Map<String, dynamic> json) {
  return RecipeStepModel(
    json['id'] == null
        ? null
        : IDModel.fromJson(json['id'] as Map<String, dynamic>),
    json['directions'] as String,
    json['step'] as int,
    (json['ingredients'] as List)
        ?.map((e) => e == null
            ? null
            : StepIngredientModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecipeStepModelToJson(RecipeStepModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'directions': instance.directions,
      'step': instance.step,
      'ingredients': instance.ingredients,
    };
