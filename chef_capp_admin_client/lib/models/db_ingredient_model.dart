import 'package:chef_capp_admin_client/index.dart';

// singular + plural interface?

class DBIngredientModel {
  final IDModel id;
  String singular;
  String plural;
  String category;
  DBIngredientUnitModel unit;

  DBIngredientModel(IDModel id, String singular, String plural, String category, DBIngredientUnitModel unit) :
        this.id = id,
        this.singular = singular,
        this.plural = plural,
        this.category = category,
        this.unit = unit;

  bool equals(var other) {
    if (other is! DBIngredientModel) return false;
    return (other as DBIngredientModel).id.equals(this.id);
  }

  static DBIngredientModel fromDB(Map<String, dynamic> data) {
    String plural = (data["name"]["plural"] ?? data["name"]["plural"]);
    return DBIngredientModel(IDModel(data["id"]), data["name"]["singular"], plural, data["category"], DBIngredientUnitModel.fromDB(data["unit"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "type": "ingredient",
      "name": {
        "singular": singular,
        "plural": plural
      },
      "category": category,
      "unit": unit.toJson()
    };
  }
}

class DBIngredientUnitModel {
  String singular;
  String plural;
  String unitCategory; // whole, specific, SI
  String measurementType; // mass, volume
  Map<String, double> _conversionFactorTo;

  DBIngredientUnitModel(String singular, String plural, String unitCategory, String measurementType, Map<String, double> conversionFactorTo) :
      this.singular = singular,
      this.plural = plural,
      this.unitCategory = unitCategory,
      this.measurementType = measurementType,
      this._conversionFactorTo = conversionFactorTo;

  Map<String, double> get conversionFactorTo => {..._conversionFactorTo};

  set conversionFactorTo(Map<String, double> conversionFactorTo) => _conversionFactorTo = {...conversionFactorTo};

  static DBIngredientUnitModel fromDB(Map<String, dynamic> data) {
    String plural = (data["plural"] ?? data["singular"]);
    Map<String, double> conversionFactorTo = Map<String, double>();
    data["conversionFactorTo"].forEach((k, v) {
      conversionFactorTo[k] = v;
    });
    return DBIngredientUnitModel(data["singular"], plural, data["unitCategory"], data["measurementType"], conversionFactorTo);
  }

  Map<String, dynamic> toJson() {
    return {
      "singular": singular,
      "plural": plural,
      "unitCategory": unitCategory,
      "measurementType": measurementType,
      "conversionFactorTo": _conversionFactorTo
    };
  }
}
