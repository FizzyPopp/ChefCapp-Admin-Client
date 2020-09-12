import 'package:chef_capp_admin_client/index.dart';

class RecipeController extends ChangeNotifier {
  final RecipeListController parent;
  String _id, _recipeName, _yield, _prepTime, _cookTime, _status;
  List<RecipeStepController> _steps;

  RecipeController(RecipeModel model, this.parent) {
    _id = model.id.toString();
    _recipeName = model.title;
    _yield = model.yield.toString();
    _prepTime = model.prepTime.toString();
    _cookTime = model.cookTime.toString();
    _steps = model.steps.map((s) => RecipeStepController(s, this)).toList();
    _status = model.status;
  }

  RecipeController.empty(this.parent) {
    _id = IDModel.nilUUID();
    _recipeName = "";
    _yield = "";
    _prepTime = "";
    _cookTime = "";
    _steps = [];
    _status = "new";
  }

  String get id => _id;

  String get recipeName => _recipeName;

  String get yield => _yield;

  String get prepTime => _prepTime;

  String get cookTime => _cookTime;

  List<RecipeStepController> get steps => [..._steps];

  String get status => _status;

  void onRecipesCrumb(BuildContext context) {
    Navigator.pop(context);
  }

  void onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void onSave(BuildContext context) {
    // send to validator
  }

  void onPublish(BuildContext context) {
    // send to db
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
    RecipeStepController out = RecipeStepController.empty(_steps.length, this);
    _steps.add(out);
    notifyListeners();
    return out;
  }

  void moveStepUp(RecipeStepController step) {
      if (step.step > 1) {
        _steps.insert(step.step - 2, _steps.removeAt(step.step - 1));
        setSteps();
        notifyListeners();
      } else {
        _steps.add(_steps.removeAt(0));
        setSteps();
        notifyListeners();
      }
  }

  bool moveStepDown(RecipeStepController step) {
    if (step.step < _steps.length) {
      _steps.insert(step.step, _steps.removeAt(step.step - 1));
      setSteps();
      notifyListeners();
    } else {
      _steps.insert(0, _steps.removeAt(_steps.length - 1));
      setSteps();
      notifyListeners();
    }
  }

  bool deleteStep(RecipeStepController step) {
    _steps.removeAt(step.step - 1);
    setSteps();
    notifyListeners();
    print("deleted step");
  }

  void setSteps() {
    for (int i = 0; i < _steps.length; i++) {
      _steps[i].step = (i+1);
    }
  }
}