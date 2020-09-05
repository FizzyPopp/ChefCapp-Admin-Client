import 'package:chef_capp_admin_client/index.dart';

class RecipeController extends ChangeNotifier {
  String _recipeName, _yield, _prepTime, _cookTime;
  List<RecipeStepController> _stepControllers;

  RecipeController(RecipeModel model) {
    _recipeName = model.title;
    _yield = model.yield;
    _prepTime = model.prepTime;
    _cookTime = model.cookTime;
    _stepControllers = model.steps.map((s) => RecipeStepController(s)).toList();
  }

  RecipeController.empty() {
    _recipeName = "";
    _yield = "";
    _prepTime = "";
    _cookTime = "";
    _stepControllers = [];
  }

  List<RecipeStepController> get stepControllers => [..._stepControllers];

  void onRecipesCrumb(BuildContext context) {
    Navigator.pop(context);
  }

  void onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void onSave(BuildContext context) {

  }

  void onPublish(BuildContext context) {

  }

  void recipeNameChanged(String newText) {
    _recipeName = newText;
  }

  void yieldChanged(String newText) {
    _yield = newText;
  }

  void prepTimeChanged(String newText) {
    _prepTime = newText;
  }

  void cookTimeChanged(String newText) {
    _cookTime = newText;
  }

  void onUploadImage() {
    // ???
  }

  RecipeStepController newStepController() {
    RecipeStepController out = RecipeStepController.empty(_stepControllers.length);
    _stepControllers.add(out);
    return out;
  }
}