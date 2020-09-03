import 'package:chef_capp_admin_client/index.dart';

class DummyModels {

  static int _id = 0;

  static IDModel id() {
    return IDModel((_id++).toString());
  }

  static RecipeModel recipe() {
    // RecipeModel(IDModel id, String title, String yield, String prepTime, String cookTime, List<StepIngredientModel> steps)
    IDModel id = DummyModels.id();
    List<RecipeStepModel> steps = [
      DummyModels.recipeStep(1),
      DummyModels.recipeStep(2),
      DummyModels.recipeStep(3),
      DummyModels.recipeStep(4),
    ];
    return RecipeModel(id, "A title $id", "yield $id", "preptime $id", "cooktime $id", steps);
  }

  static RecipeStepModel recipeStep(int step) {
    IDModel id = DummyModels.id();
    List<StepIngredientModel> steps = [

    ];
    return RecipeStepModel("directions $id", step, []);
  }

  static StepIngredientModel stepIngredient() {
    IDModel id = DummyModels.id();
    return StepIngredientModel(id, "name $id", "plural $id", double.parse(id.hash), "unit $id", "category $id");
  }

  static ZeroIngredientModel zeroIngredient() {
    return null;
  }
}