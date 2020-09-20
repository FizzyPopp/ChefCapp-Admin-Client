import 'package:chef_capp_admin_client/index.dart';

class StepIngredientModel implements EqualsInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  final IDModel id;
  final String name;
  final String plural;
  String unitCategory; // whole, specific, SI
  double quantity;
  String unit; // depends on unitCategory

  StepIngredientModel(IDModel id, String name, String plural, String unitCategory, double quantity, String unit) :
        this.id = id,
        this.name = name,
        this.plural = plural,
        this.unitCategory = unitCategory,
        this.quantity = quantity,
        this.unit = unit;

  bool equals(var other) {
    if (other is! StepIngredientModel) return false;
    return (other as StepIngredientModel).id.equals(this.id);
  }

  static StepIngredientModel fromDB(Map<String, dynamic> data) {
    return StepIngredientModel(IDModel(data["id"]), data["name"]["singular"], data["name"]["plural"], "whole", data["quantity"], data["unit"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": {
        "singular": name,
        "plural": plural,
      },
      "unit": unit,
      "quantity": quantity
    };
  }
}
