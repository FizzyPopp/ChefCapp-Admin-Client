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
    return RecipeModel(id, "A title $id", 4, 15, 30, steps, "published");
  }

  static RecipeStepModel recipeStep(int step) {
    IDModel id = DummyModels.id();
    List<StepIngredientModel> steps = [
      DummyModels.stepIngredient(),
      DummyModels.stepIngredient(),
      DummyModels.stepIngredient(),
    ];
    return RecipeStepModel("step $step (directions $id)", step, []);
  }

  static StepIngredientModel stepIngredient() {
    IDModel id = DummyModels.id();
    return StepIngredientModel(id, "name $id", "verbiage $id", double.parse(id.hash), "unit $id");
  }

  static DBIngredientModel dbIngredient() {
    IDModel id = DummyModels.id();
    return DBIngredientModel(id, "name $id", "plural $id", {}, "category $id");
  }
}