import 'package:chef_capp_admin_client/index.dart';

class RecipeListController extends ChangeNotifier {
  List<RecipeModel> _recipes;
  bool _haveRecipes;

  RecipeListController() {
    _haveRecipes = false;
    _recipes = [];
    //fillRecipes();

    // testing
    _recipes = [DummyModels.recipe(), DummyModels.recipe()];
    _haveRecipes = true;
  }

  List<RecipeModel> get recipes => [..._recipes];

  Future<void> fillRecipes() async {
    _recipes = await ParentService.database.getRecipes();
    _haveRecipes = true;
    notifyListeners();
  }

  void onAddNew(BuildContext context) {
    Navigator.push(
      context,
      FadeRoute(page: RecipePage(RecipeController.empty(this))),
    );
  }

  void onEdit(BuildContext context, RecipeModel model) {
    if (!_haveRecipes) {
      return;
    }
    Navigator.push(
      context,
      FadeRoute(page: RecipePage(RecipeController(model, this))),
    );
  }
}