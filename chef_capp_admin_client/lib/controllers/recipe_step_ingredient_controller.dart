import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  List<DBIngredientModel> _allIngredients = [];
  final RecipeStepController _parent;
  final int fakeID;
  IDModel _id;
  // verbiage and unit should really be lists
  String _name, _unitCategory, _quantity, _unit;
  static const List<String> _unitCategories = ["whole", "specific", "SI"];
  List<String> _unitOptions = [];
  // this depends on the measurement type of the ingredient, but it might work for MVP
  static const List<String> _SI = ["g", "kg", "lb", "ml", "L", "cup"];
  List<String> _specific = [];

  RecipeStepIngredientController(StepIngredientModel ingredient, this.fakeID, this._parent) {
    _id = ingredient.id;
    _name = ingredient.name;
    _unitCategory = ingredient.unitCategory;
    _quantity = ingredient.quantity.toString();
    _unit = ingredient.unit;
    setSpecific();
  }

  RecipeStepIngredientController.empty(this.fakeID, this._parent) {
    _id = IDModel.nil();
    _name = "";
    _unitCategory = "";
    _quantity = "";
    _unit = "";
    setSpecific();
  }

  StepIngredientModel toModel() {
    if ((double.tryParse(_quantity) ?? -1) <= 0) {
      return null;
    }
    return StepIngredientModel(_id, _name, _unitCategory, double.parse(quantity), _unit);
  }

  String get name => _name;
  String get unitCategory => _unitCategory;
  String get quantity => _quantity;
  String get unit => _unit;
  List<String> get unitCategories => [..._unitCategories];
  List<String> get unitOptions => [..._unitOptions];

  void setSpecific() async {
    _specific = (await ParentService.database.getSpecificUnits()).map<String>((m) => m.toString()).toList();
    setUnitOptions();
    notifyListeners();
  }

  void setAllIngredients() async {
    _allIngredients = await ParentService.database.getIngredients();
  }

  void searchIngredients(String newText) {
    // do something
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
      _unitOptions = [""];
    } else if (_unitCategory == "specific") {
      _unitOptions = [..._specific]; //(await ParentService.database.getSpecificUnits()).map<String>((m) => m.toString()).toList();
    } else if (_unitCategory == "SI") {
      _unitOptions = [..._SI];
    } else {
      throw("something went wrong");
    }
  }
}