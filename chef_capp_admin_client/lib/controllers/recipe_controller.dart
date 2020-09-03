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

class IngredientController extends ChangeNotifier {

  List<String> categoryOptions = ["Bulk Unit", "A", "B"];
  List<String> siUnitOptions = ["Bulk Unit", "A", "B"];
  List<String> cookingUnitOptions = ["Bulk Unit", "A", "B"];
  List<String> portionUnitOptions = ["Bulk Unit", "A", "B"];
  List<String> storageUnitOptions = ["Bulk Unit", "A", "B"];
  List<String> bulkUnitOptions = ["Bulk Unit", "A", "B"];

  void onEdit(BuildContext context) {

  }
  void onDelete(BuildContext context) {

  }
  void onSave(BuildContext context) {

  }
  void ingredientNameChanged(String newText) {

  }
  void ingredientTagChanged(String newText) {

  }
  void ingredientPluralChanged(String newText) {

  }
}