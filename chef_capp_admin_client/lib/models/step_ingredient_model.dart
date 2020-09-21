import 'package:chef_capp_admin_client/index.dart';

class StepIngredientModel implements EqualsInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  IDModel id;
  String name;
  String plural;
  double quantity;
  StepIngredientUnitModel unit;

  StepIngredientModel(IDModel id, String name, String plural, double quantity, StepIngredientUnitModel unit) :
        this.id = id,
        this.name = name,
        this.plural = plural,
        this.quantity = quantity,
        this.unit = unit;

  StepIngredientModel copy() {
    return StepIngredientModel(id, name, plural, quantity, unit.copy());
  }


  bool equals(var other) {
    if (other is! StepIngredientModel) return false;
    return (other as StepIngredientModel).id.equals(this.id);
  }

  static StepIngredientModel fromDB(Map<String, dynamic> data) {
    String plural = data["name"]["plural"] ?? data["name"]["singular"];
    return StepIngredientModel(IDModel(data["id"]), data["name"]["singular"], plural, data["quantity"], StepIngredientUnitModel.fromDB(data["unit"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": {
        "singular": name,
        "plural": plural,
      },
      "unit": unit.toJson(),
      "quantity": quantity
    };
  }
}

class StepIngredientUnitModel {
  String singular;
  String plural;
  String measurementType; // mass, volume
  String unitCategory; // specific, whole, SI

  static const List<StepIngredientUnitModel> wholeOptions = [];
  static final List<StepIngredientUnitModel> _siOptions =
    DBIngredientUnitModel.siOptions.map<StepIngredientUnitModel>(
            (m) => m.toStepIngredientUnitModel()).toList();
  static List<StepIngredientUnitModel> get siOptions => [..._siOptions];

  StepIngredientUnitModel(String singular, String plural, String measurementType, String unitCategory) {
    this.singular = singular;
    this.plural = plural;
    this.measurementType = measurementType;
    this.unitCategory = unitCategory;
  }

  StepIngredientUnitModel copy() {
    return StepIngredientUnitModel(singular, plural, measurementType, unitCategory);
  }

  static StepIngredientUnitModel fromDB(Map<String, dynamic> data) {
    return StepIngredientUnitModel(data["singular"], data["plural"], data["measurementType"], data["unitCategory"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "singular": singular,
      "plural": plural,
      "measurementType": measurementType,
      "unitCategory": unitCategory
    };
  }
}
