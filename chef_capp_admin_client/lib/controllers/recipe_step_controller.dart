import 'package:chef_capp_admin_client/index.dart';

class RecipeStepController extends ChangeNotifier {
  final RecipeController parent;
  int _step;
  String _directions, _newIngredient, _newVerbiage, _newQuantity, _newUnit;
  List<RecipeStepIngredientController> _ingredientControllers;

  RecipeStepController(RecipeStepModel rs, this.parent) {
    _step = rs.step;
    _directions = rs.directions;
    _ingredientControllers = rs.ingredients
        .map((m) => RecipeStepIngredientController.fromModel(m))
        .toList();
  }

  RecipeStepController.empty(int step, this.parent) {
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
    List<StepIngredientModel> ingredients =
        _ingredientControllers.map((c) => c.toModel()).toList();
    return RecipeStepModel(_directions, _step, ingredients);
  }

  void addIngredient() {
    RecipeStepIngredientController out = RecipeStepIngredientController(
        _newIngredient, _newVerbiage, _newQuantity, _newUnit);
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

  void onStepAction(stepPopupOptions x) {
    switch (x) {
      case stepPopupOptions.firstOpt:
        {
          // move up
          parent.moveStepUp(this);
        }
        break;
      case stepPopupOptions.secondOpt:
        {
          // move down
          parent.moveStepDown(this);
        }
        break;
      case stepPopupOptions.thirdOpt:
        {
          // delete
          parent.deleteStep(this);
        }
        break;
      case stepPopupOptions.fourthOpt:
        {
          // do nothing for now
        }
        break;
      default:
        {
          // do nothing for now
        }
        break;
    }
  }
}
