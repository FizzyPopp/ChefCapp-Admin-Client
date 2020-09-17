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
    _steps = [];
    _status = model.status;
    setSteps(model);
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

  Future<void> setSteps(RecipeModel model) async {
    await ParentService.database.getRecipeSteps(model);
    _steps = model.steps.map((s) => RecipeStepController(s, this)).toList();
    notifyListeners();
  }

  void onRecipesCrumb(BuildContext context) {
    Navigator.pop(context);
  }

  void onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void onSave(BuildContext context) {
    // send to validator
  }

  RecipeModel toModel() {
    if ((int.tryParse(_yield) ?? -1) < 0) {
      return null;
    }
    if ((int.tryParse(_prepTime) ?? -1) < 0) {
      return null;
    }
    if ((int.tryParse(_cookTime) ?? -1) < 0) {
      return null;
    }
    return RecipeModel(IDModel(_id), _recipeName, int.parse(_yield), int.parse(_prepTime), int.parse(_cookTime), _steps.map<RecipeStepModel>((c) => c.toModel()).toList(), _status);
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
        setStepNumbers();
        notifyListeners();
      } else {
        _steps.add(_steps.removeAt(0));
        setStepNumbers();
        notifyListeners();
      }
  }

  bool moveStepDown(RecipeStepController step) {
    if (step.step < _steps.length) {
      _steps.insert(step.step, _steps.removeAt(step.step - 1));
      setStepNumbers();
      notifyListeners();
    } else {
      _steps.insert(0, _steps.removeAt(_steps.length - 1));
      setStepNumbers();
      notifyListeners();
    }
  }

  bool deleteStep(RecipeStepController step) {
    _steps.removeAt(step.step - 1);
    setStepNumbers();
    notifyListeners();
    print("deleted step");
  }

  void setStepNumbers() {
    for (int i = 0; i < _steps.length; i++) {
      _steps[i].step = (i+1);
    }
  }
}