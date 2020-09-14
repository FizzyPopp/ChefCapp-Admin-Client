import 'package:chef_capp_admin_client/index.dart';
class IngredientCategoryModel implements EqualsInterface {
  final String _name;

  IngredientCategoryModel(String name) : this._name = name;

  String get name => _name;

  bool equals(var other) {
    if (other is! IngredientCategoryModel) return false;
    return (other as IngredientCategoryModel).name == this.name;
  }

  @override
  String toString() {
    return _name;
  }
}