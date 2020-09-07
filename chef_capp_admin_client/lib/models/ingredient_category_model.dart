import 'package:chef_capp_admin_client/index.dart';
part 'ingredient_category_model.g.dart';

@JsonSerializable()
class IngredientCategoryModel implements EqualsInterface {
  final String _value;

  IngredientCategoryModel(String value) : this._value = value;

  String get value => _value;

  bool equals(var other) {
    if (other is! IngredientCategoryModel) return false;
    return other.value == this.value;
  }

  factory IngredientCategoryModel.fromJson(Map<String, dynamic> json) => _$IngredientCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientCategoryModelToJson(this);
}