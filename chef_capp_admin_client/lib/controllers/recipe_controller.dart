import 'package:chef_capp_admin_client/index.dart';

class RecipeController extends ChangeNotifier {
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
    print(newText);
  }
  void yieldChanged(String newText) {
    print(newText);
  }
  void prepTimeChanged(String newText) {

  }
  void cookTimeChanged(String newText) {

  }
  void onUploadImage() {

  }
  RecipeStepController newStepController() {
    return null;
  }
}