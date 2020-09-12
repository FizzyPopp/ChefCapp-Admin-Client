import 'package:chef_capp_admin_client/index.dart';

class DBIngredientController extends ChangeNotifier {
  final DBIngredientListController parent;
  bool _volume;
  String _name, _plural, _category, _cookingUnit, _portionUnit;
  List<String> _tags;

  List<IngredientCategoryModel> _categoryOptions;

  final List<String> _measurementTypeOptions = ["mass", "volume"];
  List<SpecificUnitModel> _specificUnitOptions = [];

  DBIngredientController(DBIngredientModel model, this.parent) {
    _name = model.name;
    _tags = [];
    _plural = model.plural;
    _category = model.category;
    _cookingUnit = "?";
    _portionUnit = "?";

    _categoryOptions = [];
    fillCategoryOptions();
  }

  DBIngredientController.empty(this.parent);

  String get name => _name;

  List<String> get tags => [..._tags];

  String get plural => _plural;

  List<String> get measurementTypeOptions => [..._measurementTypeOptions];

  List<String> get portionUnitOptions => _specificUnitOptions.map((m) => m.value).toList();

  List<String> get cookingUnitOptions => _specificUnitOptions.map((m) => m.value).toList();

  List<String> get categoryOptions => _categoryOptions.map((m) => m.value).toList();

  Future<void> fillCategoryOptions() async {
    _categoryOptions = await ParentService.database.getIngredientCategories();
    notifyListeners();
  }

  int get categoryIndex {
    for (int i = 0; i < _categoryOptions.length; i++) {
      if (_categoryOptions[i].value == _category) {
        return i;
      }
    }
    return 0;
  }

  int get measurementType {
    if (_volume) {
      return 0;
    } else {
      return 1;
    }
  }

  int get cookingUnitIndex {
    for (int i = 0; i < _specificUnitOptions.length; i++) {
      if (_categoryOptions[i].value == _cookingUnit) {
        return i;
      }
    }
    return 0;
  }

  int get portionUnitIndex {
    for (int i = 0; i < _specificUnitOptions.length; i++) {
      if (_categoryOptions[i].value == _portionUnit) {
        return i;
      }
    }
    return 0;
  }

  void onDelete(BuildContext context) {

  }

  void onSave(BuildContext context) {

  }

  void ingredientNameChanged(String newText) {
    _name = newText;
  }

  void ingredientTagsChanged(List<String> newTags) {
    _tags = newTags;
  }

  void ingredientPluralChanged(String newText) {
    _plural = newText;
  }

  void categoryChanged(int x) {
    _category = _categoryOptions[x].value;
  }

  void measurementTypeChanged(int x) {
    _volume = (x != 0);
  }

  void cookingUnitChanged(int x) {
    _cookingUnit = _specificUnitOptions[x].value;
  }

  void portionUnitChanged(int x) {
    _portionUnit = _specificUnitOptions[x].value;
  }
}