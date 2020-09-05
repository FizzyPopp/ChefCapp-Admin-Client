import 'package:chef_capp_admin_client/index.dart';

class RecipeStepController extends ChangeNotifier {
  int _step;
  String _directions, _newIngredient, _newVerbiage, _newQuantity, _newUnit;
  List<RecipeStepIngredientController> _ingredientControllers;

  RecipeStepController(RecipeStepModel rs) {
    _step = rs.step;
    _directions = rs.directions;
    _ingredientControllers = rs.ingredients.map((m) => RecipeStepIngredientController.fromModel(m)).toList();
  }

  RecipeStepController.empty(int step) {
    _step = step;
    _directions = "";
    _ingredientControllers = [];
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

  RecipeStepModel toModel() {
    List<StepIngredientModel> ingredients = _ingredientControllers.map((c) => c.toModel()).toList();
    return RecipeStepModel(_directions, _step, ingredients);
  }

  void addIngredient() {
    RecipeStepIngredientController out = RecipeStepIngredientController(_newIngredient, _newVerbiage, _newQuantity, _newUnit);
    _ingredientControllers.add(out);
    _newIngredient = "";
    _newVerbiage = "";
    _newQuantity = "";
    _newUnit = "";
    notifyListeners();
  }

  void stepDirectionsChanged(String newText) {
    _directions = newText;
  }
}