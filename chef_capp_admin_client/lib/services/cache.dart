import 'package:chef_capp_admin_client/index.dart';

class Cache {
  ValidList<DBIngredientModel> ingredients;
  ValidList<RecipeModel> recipes;
  ValidList<String> specificUnits;
  ValidList<String> ingredientCategories;
}

class ValidList<T> {
  bool _isSet = false;
  List<T> _data;

  get isSet => _isSet;

  void invalidate() {
    _isSet = false;
  }

  set data(List<T> data) {
    _data = [...data];
    _isSet = true;
  }

  List<T> get data {
    if (_isSet) {
      return [];
    } else {
      return [..._data];
    }
  }
}
