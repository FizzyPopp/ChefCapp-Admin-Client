import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  final String name;
  String _verbiage, _quantity, _unit;

  RecipeStepIngredientController(this.name, this._verbiage, this._quantity, this._unit);

  RecipeStepIngredientController.fromModel(StepIngredientModel ingredient) : this.name = ingredient.name {
    _verbiage = "";
    _quantity = ingredient.quantity.toString();
    _unit = ingredient.unit.toString();
  }

  String get verbiage => _verbiage;
  String get quantity => _quantity;
  String get unit => _unit;

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
    // do something
  }
}