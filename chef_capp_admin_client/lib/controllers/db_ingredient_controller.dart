import 'package:chef_capp_admin_client/index.dart';

class DBIngredientController extends ChangeNotifier {
  final DBIngredientListController parent;
  IDModel _id;
  String _name, _plural, _category;
  List<IngredientCategoryModel> _categoryOptions= [];
  Map<String, DBIngredientUnitController> _units = {
    "cooking": DBIngredientUnitController.empty(),
    "portion": DBIngredientUnitController.empty()
  };
  static const List<String> _measurementTypeOptions = ["mass", "volume"];

  DBIngredientController(DBIngredientModel model, this.parent) {
    _id = model.id;
    _name = model.singular;
    _plural = model.plural;
    _category = model.category;
    model.units.forEach((String key, DBIngredientUnitModel value) {
      _units[key] = DBIngredientUnitController(value.singular, value.plural, value.measurementType, value.unitCategory, value.conversionFactorTo);
    });
    _setCategoryOptions();
  }

  DBIngredientController.empty(this.parent) {
    _id = IDModel.nil();
    _name = "";
    _plural = "";
    _category = "";
    _setCategoryOptions();
  }

  String get name => _name;

  String get plural => _plural;

  int get category {
    List<String> tmp = _categoryOptions.map<String>((m) => m.name).toList();
    if (tmp.contains(_category)) {
      return tmp.indexOf(_category);
    } else {
      return 0;
    }
  }

  List<String> get measurementTypeOptions => [..._measurementTypeOptions];

  List<String> get categoryOptions => _categoryOptions.map((m) => m.name).toList();

  Map<String, DBIngredientUnitController> get units => {..._units};

  Future<void> _setCategoryOptions() async {
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

  void onDelete(BuildContext context) {
    print("delete ingredient");
  }

  void onSave(BuildContext context) async {
    ParentService.database.saveIngredient(toModel());

    // close window?
  }

  DBIngredientModel toModel() {
    Map<String, DBIngredientUnitModel> modelUnits = Map<String, DBIngredientUnitModel>();
    _units.forEach((String key, DBIngredientUnitController value) {
      modelUnits[key] = value.toModel();
    });
    return DBIngredientModel(_id, _name, _plural, _category, modelUnits);
    //return DBIngredientModel(_id, _name, _plural, _category, measurementType, modelUnits);
  }

  void ingredientNameChanged(String newText) {
    _name = newText;
  }

  void ingredientPluralChanged(String newText) {
    _plural = newText;
  }

  void categoryChanged(int x) {
    _category = _categoryOptions[x].name;
  }
}

class DBIngredientUnitController extends ChangeNotifier {
  String _singular, _plural, _measurementType, _unitCategory;
  double _conversionFactorTo;

  DBIngredientUnitController(this._singular, this._plural, this._measurementType, this._unitCategory, this._conversionFactorTo);

  DBIngredientUnitController.empty() {
    _singular = "";
    _plural = "";
    _measurementType = "";
    _unitCategory = "";
    _conversionFactorTo = 0;
  }

  String get singular => _singular;

  String get plural => _plural;

  String get measurementType => _measurementType;

  String get unitCategory => _unitCategory;

  double get conversionFactorTo => _conversionFactorTo;

  void singularChanged(String newText) {
    _singular = newText;
  }

  void pluralChanged(String newText) {
    _plural = newText;
  }

  void measurementTypeChanged(String x) {
    _measurementType = x;
  }

  void unitCategoryChanged(String x) {
    _unitCategory = x;
  }

  void conversionFactorToChanged(String newText) {
    _conversionFactorTo = double.tryParse(newText) ?? 0;
  }

  DBIngredientUnitModel toModel() {
    return DBIngredientUnitModel(_singular, _plural, _measurementType, _unitCategory, _conversionFactorTo);
  }
}