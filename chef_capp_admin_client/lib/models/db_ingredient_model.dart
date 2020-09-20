import 'package:chef_capp_admin_client/index.dart';
import 'dart:convert';

// singular + plural interface?

class DBIngredientModel {
  final IDModel id;
  String singular;
  String plural;
  String category;
  String measurementType;
  Map<String, DBIngredientUnitModel> _units;

  DBIngredientModel(IDModel id, String singular, String plural, String category, String measurementType, Map<String, DBIngredientUnitModel> units) :
        this.id = id,
        this.singular = singular,
        this.plural = plural,
        this.category = category,
        this.measurementType = measurementType,
        this._units = units;

  Map<String, DBIngredientUnitModel> get units => {..._units};

  set units(Map<String, DBIngredientUnitModel> units) => _units = {...units};

  bool equals(var other) {
    if (other is! DBIngredientModel) return false;
    return (other as DBIngredientModel).id.equals(this.id);
  }

  static DBIngredientModel fromDB(Map<String, dynamic> data) {
    String plural = (data["name"]["plural"] ?? data["name"]["plural"]);
    Map<String, DBIngredientUnitModel> units = Map<String, DBIngredientUnitModel>();
    if (data["unit"].containsKey("cooking")) {
      units["cooking"] = DBIngredientUnitModel(
          data["unit"]["cooking"]["singular"],
          data["unit"]["cooking"]["plural"],
          data["unit"]["cooking"]["unitCategory"],
          data["conversionFactorTo"]["cooking"]);
    }
    if (data["unit"].containsKey("portion")) {
      units["portion"] = DBIngredientUnitModel(
          data["unit"]["portion"]["singular"],
          data["unit"]["portion"]["plural"],
          data["unit"]["portion"]["unitCategory"],
          data["conversionFactorTo"]["portion"]);
    }
    return DBIngredientModel(IDModel(data["id"]), data["name"]["singular"], plural, data["category"], data["measurementType"], units);
  }

  Map<String, dynamic> toJson() {
    Map<String, double> conversionFactorToJson = Map<String, double>();
    Map<String, Map<String, String>> unitsJson = Map<String, Map<String, String>>();
    _units.forEach((String key, DBIngredientUnitModel value) {
      conversionFactorToJson[key] = value.conversionFactorTo;
      unitsJson[key] = {
        "singular": value.singular,
        "plural": value.plural,
        "unitCategory": value.unitCategory
      };
    });
    return {
      "id": id.toString(),
      "type": "ingredient",
      "name": {
        "singular": singular,
        "plural": plural
      },
      "category": category,
      "measurementType": measurementType,
      "conversionFactorTo": conversionFactorToJson,
      "unit": unitsJson
    };
  }
}

class DBIngredientUnitModel {
  String singular;
  String plural;
  String unitCategory; // whole, specific, SI
  double conversionFactorTo;

  DBIngredientUnitModel(String singular, String plural, String unitCategory, double conversionFactorTo) :
      this.singular = singular,
      this.plural = plural,
      this.unitCategory = unitCategory,
      this.conversionFactorTo = conversionFactorTo;

  Map<String, dynamic> toJson() {
    return {
      "singular": singular,
      "plural": plural,
      "unitCategory": unitCategory
    };
  }
}
