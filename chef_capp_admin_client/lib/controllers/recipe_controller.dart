import 'package:chef_capp_admin_client/index.dart';

class RecipeController extends ChangeNotifier {
  final RecipeListController parent;
  String _recipeName, _yield, _prepTime, _cookTime;
  List<RecipeStepController> _stepControllers;

  RecipeController(RecipeModel model, this.parent) {
    _recipeName = model.title;
    _yield = model.yield.toString();
    _prepTime = model.prepTime.toString();
    _cookTime = model.cookTime.toString();
    _stepControllers = model.steps.map((s) => RecipeStepController(s, this)).toList();
  }

  RecipeController.empty(this.parent) {
    _recipeName = "";
    _yield = "";
    _prepTime = "";
    _cookTime = "";
    _stepControllers = [];
  }

  String get recipeName => _recipeName;

  String get yield => _yield;

  String get prepTime => _prepTime;

  String get cookTime => _cookTime;

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
    RecipeStepController out = RecipeStepController.empty(_stepControllers.length, this);
    _stepControllers.add(out);
    return out;
  }

  bool moveStepUp(RecipeStepController step) {

  }

  bool moveStepDown(RecipeStepController step) {

  }

  bool deleteStep(RecipeStepController step) {

  }
}