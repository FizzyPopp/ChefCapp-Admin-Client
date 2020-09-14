import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  final RecipeStepController _parent;
  final int fakeID;
  IDModel _id;
  // verbiage and unit should really be lists
  String _name, _unitCategory, _quantity, _unit;
  static const List<String> unitCategories = ["whole", "specific", "SI"];
  List<String> _unitOptions;


  RecipeStepIngredientController(StepIngredientModel ingredient, this.fakeID, this._parent) {
    _id = ingredient.id;
    _name = ingredient.name;
    _unitCategory = ingredient.unitCategory;
    _quantity = ingredient.quantity.toString();
    _unit = ingredient.unit;
    _unitOptions = getUnitOptions();
  }

  RecipeStepIngredientController.empty(this.fakeID, this._parent) {
    _id = IDModel.nil();
    _name = "";
    _unitCategory = "";
    _quantity = "";
    _unit = "";
    _unitOptions = getUnitOptions();
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

  void searchIngredients(String newText) {
    // do something
  }

  void unitCategoryChanged(String x) {
    _unitCategory = x;
    _unitOptions = getUnitOptions();
  }

  void quantityChanged(String newText) {
    _quantity = newText;
  }

  void unitChanged(String x) {
    _unit = x;
  }

  void onDelete() {
    _parent.deleteIngredient(this);
    // do something
  }

  List<String> getUnitOptions() {
    if (_unitCategory == "whole") {
      return [""];
    } else if (_unitCategory == "specific") {
      return [""]; //(await ParentService.database.getSpecificUnits()).map<String>((m) => m.toString()).toList();
    } else if (_unitCategory == "SI") {
      // need to know measurement type
      return ["kg", "L"];
    } else {
      throw("something went wrong");
    }
  }
}