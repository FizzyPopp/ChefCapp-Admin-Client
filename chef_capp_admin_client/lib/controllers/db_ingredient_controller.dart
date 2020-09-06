import 'package:chef_capp_admin_client/index.dart';

class DBIngredientController extends ChangeNotifier {
  final DBIngredientListController parent;
  bool _volume;
  String _name, _tag, _plural, _category, _cookingUnit, _portionUnit;

  // pull from collection "ingredients" -> doc "metadata" -> "categories"
  List<String> categoryOptions = [
    "bread and bakery",
    "produce",
    "animal-based proteins",
    "plant-based proteins",
    "dairy",
    "deli",
    "cans and jars",
    "dry goods",
    "frozen goods",
    "oils and condiments",
    "spices and herbs",
    "other"
  ];

  List<String> measurementTypeOptions = ["mass", "volume"];
  List<String> cookingUnitOptions = ["?"];
  List<String> portionUnitOptions = ["?"];

  DBIngredientController(DBIngredientModel model, this.parent) {
    _name = model.name;
    _tag = "?";
    _plural = model.plural;
    _category = model.category;
    _cookingUnit = "?";
    _portionUnit = "?";
  }

  String get name => _name;

  String get tag => _tag;

  String get plural => _plural;

  int get category => _indexOf(categoryOptions, _category);

  int get measurementType {
    if (_volume) {
      return 0;
    } else {
      return 1;
    }
  }

  int get cookingUnit => _indexOf(cookingUnitOptions, _cookingUnit);

  int get portionUnit => _indexOf(portionUnitOptions, _portionUnit);

  int _indexOf(List<String> l, String s) {
    if (l.contains(s)) {
      return l.indexOf(s);
    } else {
      return 0;
    }
  }

  DBIngredientController.empty(this.parent);

  void onDelete(BuildContext context) {

  }
  void onSave(BuildContext context) {

  }
  void ingredientNameChanged(String newText) {
    _name = newText;
  }
  void ingredientTagChanged(String newText) {
    _tag = newText;
  }
  void ingredientPluralChanged(String newText) {
    _plural = newText;
  }

  void categoryChanged(int x) {
    _category = categoryOptions[x];
  }

  void measurementTypeChanged(int x) {
    _volume = (x != 0);
  }

  void cookingUnitChanged(int x) {
    _cookingUnit = cookingUnitOptions[x];
  }

  void portionUnitChanged(int x) {
    _portionUnit = portionUnitOptions[x];
  }


}