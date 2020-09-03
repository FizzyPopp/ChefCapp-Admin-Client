import 'package:chef_capp_admin_client/index.dart';

class RecipeStepController extends ChangeNotifier {
  int _step;
  String _directions, _newIngredient, _newVerbiage, _newQuantity, _newUnit;
  List<RecipeStepIngredientController> _ingredientControllers;

  RecipeStepController(this._step, this._directions, List<StepIngredientModel> ingredients) {
    _ingredientControllers = [];
  }

  RecipeStepController.fromModel(RecipeStepModel rs) {
    _step = rs.step;
    _directions = rs.directions;
    _ingredientControllers = rs.ingredients.map((m) => RecipeStepIngredientController.fromModel(m)).toList();
  }

  int get step => _step;
  String get directions => _directions;

  void findIngredientChanged(String newText) {
    _newIngredient = newText;
    // bring up suggestions
  }

  void verbiageChanged(x) {
    _newVerbiage = x;
  }

  void quantityChanged(String newText) {
    _newQuantity = newText;
  }

  void unitChanged(x) {
    _newUnit = x;
  }

  void addIngredient() {
    RecipeStepIngredientController out = RecipeStepIngredientController(_newIngredient, _newVerbiage, _newQuantity, _newUnit);
    _ingredientControllers.add(out);
    notifyListeners();
  }

  void stepDirectionsChanged(String newText) {
    _directions = newText;
  }
}