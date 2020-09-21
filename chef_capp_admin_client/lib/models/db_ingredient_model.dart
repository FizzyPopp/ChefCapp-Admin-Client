import 'package:chef_capp_admin_client/index.dart';
import 'dart:convert';

// singular + plural interface?

class DBIngredientModel {
  final IDModel id;
  String singular;
  String plural;
  String category; // bread and bakery, produce, meat and seafood, etc.
  Map<String, DBIngredientUnitModel> _units;

  DBIngredientModel(IDModel id, String singular, String plural, String category, Map<String, DBIngredientUnitModel> units) :
        this.id = id,
        this.singular = singular,
        this.plural = plural,
        this.category = category,
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
          data["unit"]["measurementType"],
          data["unit"]["cooking"]["unitCategory"],
          data["unit"]["conversionFactorTo"]["cooking"]);
    }
    if (data["unit"].containsKey("portion")) {
      units["portion"] = DBIngredientUnitModel(
          data["unit"]["portion"]["singular"],
          data["unit"]["portion"]["plural"],
          data["unit"]["measurementType"],
          data["unit"]["portion"]["unitCategory"],
          data["unit"]["conversionFactorTo"]["portion"]);
    }
    return DBIngredientModel(IDModel(data["id"]), data["name"]["singular"], plural, data["category"], units);
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
      "conversionFactorTo": conversionFactorToJson,
      "unit": unitsJson
    };
  }
}

class DBIngredientUnitModel {
  String singular;
  String plural;
  String measurementType; // mass, volume
  String unitCategory; // whole, specific, SI
  double conversionFactorTo;

  static const List<String> measurementTypeOptions = ["", "mass", "volume"];
  static const List<String> unitCategoryOptions = ["", "whole", "specific", "SI"];

  static const List<DBIngredientUnitModel> wholeOptions = [];
  static final List<DBIngredientUnitModel> _siOptions = [
    DBIngredientUnitModel("kg", "kg", "mass", "SI", 1),
    DBIngredientUnitModel("lb", "lbs", "mass", "SI", 2.20462),
    DBIngredientUnitModel("g", "g", "mass", "SI", 1000),
    DBIngredientUnitModel("mL", "mL", "volume", "SI", 1000),
    DBIngredientUnitModel("L", "L", "volume", "SI", 1),
    DBIngredientUnitModel("cup", "cups", "volume", "SI", 4.22675),
  ];
  static List<DBIngredientUnitModel> get siOptions => [..._siOptions];

  DBIngredientUnitModel(String singular, String plural, String measurementType, String unitCategory, double conversionFactorTo) :
      this.singular = singular,
      this.plural = plural,
      this.measurementType = measurementType,
      this.unitCategory = unitCategory,
      this.conversionFactorTo = conversionFactorTo;

  Map<String, dynamic> toJson() {
    return {
      "singular": singular,
      "plural": plural,
      "measurementType": measurementType,
      "unitCategory": unitCategory,
    };
  }

  StepIngredientUnitModel toStepIngredientUnitModel() {
    return StepIngredientUnitModel(singular, plural, measurementType, unitCategory);
  }

  static DBIngredientUnitModel fromDB(String singular, Map<String, dynamic> data) {
    return DBIngredientUnitModel(singular, data["plural"], "mass", "whole", 1);
  }
}
