import 'package:chef_capp_admin_client/index.dart';

class RecipeController extends ChangeNotifier {
  String _recipeName, _yield, _prepTime, _cookTime;
  List<RecipeStepController> stepControllers;

  RecipeController() {
    stepControllers = [];
  }

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
    RecipeStepController out = RecipeStepController(stepControllers.length);
    stepControllers.add(out);
    return out;
  }
}