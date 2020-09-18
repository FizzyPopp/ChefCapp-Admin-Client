import 'package:chef_capp_admin_client/index.dart';

class DBIngredientController extends ChangeNotifier {
  final DBIngredientListController parent;
  bool _volume;
  IDModel _id;
  String _name, _plural, _category, _cookingUnit, _portionUnit;
  List<String> _tags;

  List<IngredientCategoryModel> _categoryOptions;

  final List<String> _measurementTypeOptions = ["mass", "volume"];
  List<SpecificUnitModel> _specificUnitOptions = [];

  DBIngredientController(DBIngredientModel model, this.parent) {
    _id = model.id;
    _name = model.singular;
    _plural = model.plural;
    _category = model.category;
    _cookingUnit = "?";
    _portionUnit = "?";
    _tags = [];

    _categoryOptions = [];
    fillCategoryOptions();
  }

  DBIngredientController.empty(this.parent) {
    _id = IDModel.nil();
    _tags = [];
    _categoryOptions = [];
    fillCategoryOptions();
  }

  String get name => _name;

  List<String> get tags => [..._tags];

  String get plural => _plural;

  List<String> get measurementTypeOptions => [..._measurementTypeOptions];

  List<String> get portionUnitOptions => _specificUnitOptions.map((m) => m.singular).toList();

  List<String> get cookingUnitOptions => _specificUnitOptions.map((m) => m.singular).toList();

  List<String> get categoryOptions => _categoryOptions.map((m) => m.name).toList();

  Future<void> fillCategoryOptions() async {
    _categoryOptions = await ParentService.database.getIngredientCategories();
    notifyListeners();
  }

  int get categoryIndex {
    for (int i = 0; i < _categoryOptions.length; i++) {
      if (_categoryOptions[i].name == _category) {
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
      if (_categoryOptions[i].name == _cookingUnit) {
        return i;
      }
    }
    return 0;
  }

  int get portionUnitIndex {
    for (int i = 0; i < _specificUnitOptions.length; i++) {
      if (_categoryOptions[i].name == _portionUnit) {
        return i;
      }
    }
    return 0;
  }

  void onDelete(BuildContext context) {

  }

  void onSave(BuildContext context) {

  }

  DBIngredientModel toModel() {
    DBIngredientUnitModel unit = DBIngredientUnitModel("something", "somethings", "whole", "mass", {});
    return DBIngredientModel(_id, _name, _plural, _category, unit);
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
    _category = _categoryOptions[x].name;
  }

  void measurementTypeChanged(int x) {
    _volume = (x != 0);
  }

  void cookingUnitChanged(int x) {
    _cookingUnit = _specificUnitOptions[x].singular;
  }

  void portionUnitChanged(int x) {
    _portionUnit = _specificUnitOptions[x].singular;
  }
}