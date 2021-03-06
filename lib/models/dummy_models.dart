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
    return RecipeStepModel(id, "instructions for step with id $id", step, steps);
  }

  static StepIngredientModel stepIngredient() {
    IDModel id = DummyModels.id();
    return StepIngredientModel(id, "name $id", "plural $id", double.parse(id.value), stepIngredientUnit());
  }

  static StepIngredientUnitModel stepIngredientUnit() {
    return StepIngredientUnitModel("singular", "plural", "mass", "specific");
  }

  static DBIngredientModel dbIngredient() {
    IDModel id = DummyModels.id();
    return DBIngredientModel(id, "singular $id", "plural $id", "bread and bakery", {"kitchen": dbIngredientUnit()});
  }

  static DBIngredientUnitModel dbIngredientUnit() {
    DBIngredientUnitModel("cup", "cups", "volume", "SI", 1);
  }
}