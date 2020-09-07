import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  final RecipeStepController _parent;
  final int fakeID;
  String _name, _verbiage, _quantity, _unit;

  RecipeStepIngredientController(StepIngredientModel ingredient, this.fakeID, this._parent) {
    _name = ingredient.name;
    _verbiage = "";
    _quantity = ingredient.quantity.toString();
    _unit = ingredient.unit;
  }

  RecipeStepIngredientController.empty(this.fakeID, this._parent) {
    _name = "";
    _verbiage = "";
    _quantity = "";
    _unit = "";
  }

  double _parseQuantity() {
    return (double.tryParse(_quantity) ?? 0);
  }

  StepIngredientModel toModel() {
    if (_parseQuantity() == 0) {
      throw("bad quantity");
    } else {
      return StepIngredientModel(null, _name, _verbiage, _parseQuantity(), _unit);
    }
  }

  String get name => _name;
  String get verbiage => _verbiage;
  String get quantity => _quantity;
  String get unit => _unit;

  void searchIngredients(String newText) {
    // do something
  }

  void verbiageChanged(x) {
    _verbiage = x;
  }

  void quantityChanged(String newText) {
    _quantity = newText;
  }

  void unitChanged(x) {
    _unit = x;
  }

  void onDelete() {
    _parent.deleteIngredient(this);
    // do something
  }
}