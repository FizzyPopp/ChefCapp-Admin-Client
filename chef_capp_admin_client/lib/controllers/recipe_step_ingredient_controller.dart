import 'package:chef_capp_admin_client/index.dart';

class RecipeStepIngredientController extends ChangeNotifier {
  final String name;
  String _verbiage, _quantity, _unit;

  RecipeStepIngredientController(this.name, this._verbiage, this._quantity, this._unit);

  void verbiageChanged(x) {
    _verbiage = x;
  }

  void quantityChanged(String newText) {
    _quantity = newText;
  }

  void unitChanged(x) {
    _unit = x;
  }
}