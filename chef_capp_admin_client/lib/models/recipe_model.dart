import 'package:chef_capp_admin_client/index.dart';

// when saving a recipe:
// push recipe and list of steps to "stamper" -> get back a full recipe
// then that full recipe will get validated
// so the "toJson()" function is really not meant for validation

class RecipeModel implements EqualsInterface {
  final IDModel id;
  String title;
  int yield;
  int prepTime;
  int cookTime;
  List<RecipeStepModel> _steps;
  String status;

  RecipeModel(IDModel id, String title, int yield, int prepTime, int cookTime, List<RecipeStepModel> steps, String status) :
      this.id = id,
      this.title = title,
      this.yield = yield,
      this.prepTime = prepTime,
      this.cookTime = cookTime,
      this._steps = [...steps],
      this.status = status;

  List<RecipeStepModel> get steps => [..._steps];

  set steps(List<RecipeStepModel> steps) => _steps = [...steps];

  static RecipeModel fromDB(data) {
    // TODO: yield, steps, status
    List<RecipeStepModel> steps = [];
    for (int i = 0; i < data["components"].length; i++) {
      steps.add(RecipeStepModel(IDModel(data["components"][i]), "", i+1, []));
    }
    return RecipeModel(IDModel(data["id"]), data["name"]["singular"], 0, data["time"]["prepare"], data["time"]["cook"], steps, "published");
  }

  bool equals(var other) {
    if (other is! RecipeModel) return false;
    return (other as RecipeModel).id.equals(this.id);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "type": "recipe",
      "name": {
        "singular": title
      },
      "tags": [],
      "time": {
        "prepare": prepTime,
        "cook": cookTime,
      },
      "ingredients": {"keys": []},
      "components": []
    };
  }

  List<Map<String, dynamic>> stepsToJson() {
    List<Map<String, dynamic>> stepsJson = [];
    for (RecipeStepModel m in _steps) {
      stepsJson.add(m.toJson());
    }
    for (int i = 1; i < stepsJson.length; i++) {
      stepsJson[i]["previous"] = stepsJson[i-1]["id"];
      stepsJson[i-1]["next"] = stepsJson[i]["id"];
    }
    return stepsJson;
  }
}