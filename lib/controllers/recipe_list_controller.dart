import 'package:chef_capp_admin_client/index.dart';

class RecipeListController extends ChangeNotifier {
  List<RecipeModel> _recipes = [];

  RecipeListController() {
    setRecipes();
    ParentService.database.getIngredients(); // might as well, we're going to need them later

    // testing
    //_recipes = [DummyModels.recipe(), DummyModels.recipe()];
  }

  void setRecipes() async {
    _recipes = await ParentService.database.getRecipes();
    notifyListeners();
  }

  List<RecipeModel> get recipes => [..._recipes];

  void onAddNew(BuildContext context) {
    Navigator.push(
      context,
      FadeRoute(page: RecipePage(RecipeController.empty(this))),
    );
  }

  void onEdit(BuildContext context, RecipeModel model) {
    Navigator.push(
      context,
      FadeRoute(page: RecipePage(RecipeController(model, this))),
    );
  }
}