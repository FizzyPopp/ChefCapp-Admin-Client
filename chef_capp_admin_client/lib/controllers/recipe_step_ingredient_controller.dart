import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  IngredientOptionsController _ingredientOptionsController;
  final RecipeStepController _parent;
  final int fakeID;
  IDModel _id;
  // verbiage and unit should really be lists
  String _name, _plural, _unitCategory, _quantity, _unit;
  static const List<String> unitCategoryOptions = DBIngredientUnitController.unitCategoryOptions;
  List<String> _unitOptions = [];
  // this depends on the measurement type of the ingredient, but it might work for MVP
  static const List<String> SI = ["g", "kg", "lb", "ml", "L", "cup"];
  List<String> _specific = [];

  RecipeStepIngredientController(StepIngredientModel ingredient, this.fakeID, this._parent) {
    _id = ingredient.id;
    _name = ingredient.name;
    _plural = ingredient.plural;
    _unitCategory = ingredient.unitCategory;
    _quantity = ingredient.quantity.toString();
    _unit = ingredient.unit;
    _ingredientOptionsController = IngredientOptionsController(_name, _update);
    setSpecific();
  }

  RecipeStepIngredientController.empty(this.fakeID, this._parent) {
    _id = IDModel.nil();
    _name = "";
    _plural = "";
    _unitCategory = "whole";
    _quantity = "";
    _unit = "";
    _ingredientOptionsController = IngredientOptionsController(_name, _update);
    setSpecific();
  }

  StepIngredientModel toModel() {
    if ((double.tryParse(_quantity) ?? -1) <= 0) {
      return null;
    }
    return StepIngredientModel(_id, _name, _plural, _unitCategory, double.parse(quantity), _unit);
  }

  String get name => _name;
  String get unitCategory => _unitCategory;
  String get quantity => _quantity;
  String get unit => _unit;
  List<String> get unitOptions => [..._unitOptions];
  List<DBIngredientModel> get ingredientOptions => [..._ingredientOptionsController.options];
  IngredientOptionsController get optionsController => _ingredientOptionsController;
  TextEditingController get fieldController => _ingredientOptionsController.fieldController;

  void _update(DBIngredientModel model) {
    _id = model.id;
    _name = model.singular;
    _plural = model.plural;
  }

  void setSpecific() async {
    _specific = (await ParentService.database.getSpecificUnits()).map<String>((m) => m.toString()).toList();
    setUnitOptions();
    notifyListeners();
  }

  void searchIngredients(String newText) {
    _ingredientOptionsController.searchIngredients(newText);
  }

  void unitCategoryChanged(String x) {
    _unitCategory = x;
    setUnitOptions();
  }

  void quantityChanged(String newText) {
    _quantity = newText;
  }

  void unitChanged(String x) {
    _unit = x;
  }

  void onDelete() {
    _parent.deleteIngredient(this);
  }

  void setUnitOptions() {
    if (_unitCategory == "whole") {
      _unitOptions = [];
    } else if (_unitCategory == "specific") {
      _unitOptions = [..._specific];
    } else if (_unitCategory == "SI") {
      _unitOptions = SI;
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