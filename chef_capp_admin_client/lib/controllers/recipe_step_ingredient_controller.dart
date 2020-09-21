import 'package:chef_capp_admin_client/index.dart';

// most controller should be changed to use an underlying _modelOut
class RecipeStepIngredientController extends ChangeNotifier {
  IngredientOptionsController _ingredientOptionsController;
  final RecipeStepController _parent;
  final int fakeID;

  List<StepIngredientUnitModel> _unitOptions = [];
  List<StepIngredientUnitModel> _specificUnitOptions = [];

  StepIngredientModel _modelOut;

  RecipeStepIngredientController(StepIngredientModel ingredient, this.fakeID, this._parent) {
    _ingredientOptionsController = IngredientOptionsController(ingredient.name, _update);
    _modelOut = ingredient.copy();
    setSpecificUnitOptions();
    setUnitOptions();
  }

  RecipeStepIngredientController.empty(this.fakeID, this._parent) {
    _ingredientOptionsController = IngredientOptionsController("", _update);
    _modelOut = null;
    setSpecificUnitOptions();
    setUnitOptions();
  }

  StepIngredientModel toModel() {
    if (_modelOut == null) {
      return null;
    }
    return _modelOut;
  }

  String get name => _modelOut.name;
  String get unitCategory => _modelOut.unit.unitCategory;
  String get quantity => _modelOut.quantity.toString();
  int get unit => _unitOptions.indexOf(_modelOut.unit);
  List<String> get unitOptions => _unitOptions.map<String>((m) => m.singular).toList();
  IngredientOptionsController get optionsController => _ingredientOptionsController;
  TextEditingController get fieldController => _ingredientOptionsController.fieldController;
  List<DBIngredientModel> get ingredientOptions => [..._ingredientOptionsController.options];

  void _update(DBIngredientModel model) {
    _modelOut.id = model.id;
    _modelOut.name = model.singular;
    _modelOut.plural = model.plural;
  }

  void setSpecificUnitOptions() async {
    _specificUnitOptions = (await ParentService.database.getSpecificUnits()).map<StepIngredientUnitModel>((m) => m.toStepIngredientUnitModel()).toList();
    setUnitOptions();
    notifyListeners();
  }

  void searchIngredients(String newText) {
    _ingredientOptionsController.searchIngredients(newText);
  }

  void unitCategoryChanged(String x) {
    _modelOut.unit.unitCategory = x;
    setUnitOptions();
  }

  void quantityChanged(String newText) {
    _modelOut.quantity = double.tryParse(newText) ?? 0;
  }

  void unitChanged(int x) {
    _modelOut.unit = _unitOptions[x];
  }

  void onDelete() {
    _parent.deleteIngredient(this);
  }

  void setUnitOptions() {
    if (_modelOut.unit.unitCategory == "whole") {
      _unitOptions = StepIngredientUnitModel.wholeOptions;
    } else if (_modelOut.unit.unitCategory == "specific") {
      _unitOptions = [..._specificUnitOptions];
    } else if (_modelOut.unit.unitCategory == "SI") {
      _unitOptions = StepIngredientUnitModel.siOptions;
    } else {
      _unitOptions = [];
    }
  }
}

class IngredientOptionsController extends ChangeNotifier {
  List<DBIngredientModel> _allIngredients = [];
  List<DBIngredientModel> _ingredientOptions = [];
  final TextEditingController fieldController;
  final Function _updateParent;

  IngredientOptionsController(String name, this._updateParent) : fieldController = TextEditingController(text: name) {
    setAllIngredients();
  }

  List<DBIngredientModel> get options => [..._ingredientOptions];

  void setAllIngredients() async {
    _allIngredients = await ParentService.database.getIngredients();
  }

  void searchIngredients(String newText) {
    _ingredientOptions = [];
    if (newText != "") {
      for (DBIngredientModel m in _allIngredients) {
        if (m.singular.toLowerCase().contains(newText.toLowerCase())) {
          _ingredientOptions.add(m);
        }
      }
    }
    notifyListeners();
  }

  void ingredientOptionTapped(DBIngredientModel model) {
    fieldController.text = model.singular;
    _updateParent(model);
  }
}