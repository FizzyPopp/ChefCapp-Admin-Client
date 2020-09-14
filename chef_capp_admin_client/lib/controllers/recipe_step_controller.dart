import 'package:chef_capp_admin_client/index.dart';

class RecipeStepController extends ChangeNotifier {
  final RecipeController parent;
  IDModel _id;
  int _step;
  String _directions;
  List<RecipeStepIngredientController> _ingredients;
  Function genFakeID = fakeIDClosure();

  static Function fakeIDClosure() {
    int fakeID = 0;
    return () {
      return fakeID++;
    };
  }

  RecipeStepController(RecipeStepModel rs, this.parent) {
    _id = rs.id;
    _step = rs.step;
    _directions = rs.directions;
    _ingredients = rs.ingredients
        .map((m) => RecipeStepIngredientController(m, genFakeID(), this))
        .toList();
    if (_ingredients.length == 0) {
      _ingredients = [RecipeStepIngredientController.empty(genFakeID(), this)];
    }
  }

  RecipeStepController.empty(int step, this.parent) {
    _id = IDModel.nil();
    _step = step;
    _directions = "";
    _ingredients = [];
  }

  int get step => _step;

  set step(int i) => _step = i;

  String get directions => _directions;

  List<RecipeStepIngredientController> get ingredients => [..._ingredients];

  RecipeStepModel toModel() {
    return RecipeStepModel(_id, _directions, _step, _ingredients.map<StepIngredientModel>((c) => c.toModel()).toList());
  }

  void onAddIngredient() {
    _ingredients.add(RecipeStepIngredientController.empty(genFakeID(), this));
    _ingredients = [..._ingredients];
    notifyListeners();
  }

  bool deleteIngredient(RecipeStepIngredientController rsic) {
    int initialLen = _ingredients.length;
    _ingredients.removeWhere((elem) => elem.fakeID == rsic.fakeID);
    _ingredients = [..._ingredients];
    notifyListeners();
    return(_ingredients.length != initialLen);
  }

  void stepDirectionsChanged(String newText) {
    _directions = newText;
  }

  void onStepAction(stepPopupOptions x) {
    switch (x) {
      case stepPopupOptions.firstOpt:
        {
          // move up
          parent.moveStepUp(this);
        }
        break;
      case stepPopupOptions.secondOpt:
        {
          // move down
          parent.moveStepDown(this);
        }
        break;
      case stepPopupOptions.thirdOpt:
        {
          // delete
          parent.deleteStep(this);
        }
        break;
      case stepPopupOptions.fourthOpt:
        {
          // do nothing for now
        }
        break;
      default:
        {
          // do nothing for now
        }
        break;
    }
  }
}
