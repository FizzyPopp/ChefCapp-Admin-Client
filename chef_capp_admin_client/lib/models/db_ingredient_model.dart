import 'package:chef_capp_admin_client/index.dart';

// singular + plural interface?

class DBIngredientModel {
  final IDModel _id;
  final String _singular;
  final String _plural;
  final String _category;
  final DBIngredientUnitModel _unit;

  DBIngredientModel(IDModel id, String singular, String plural, String category, DBIngredientUnitModel unit) :
        this._id = id,
        this._singular = singular,
        this._plural = plural,
        this._category = category,
        this._unit = unit;

  IDModel get id => _id;

  String get singular => _singular;

  String get plural => _plural;

  String get category => _category;

  DBIngredientUnitModel get unit => _unit;

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
      "id": _id.toString(),
      "type": "ingredient",
      "name": {
        "singular": _singular,
        "plural": _plural
      },
      "category": _category,
      "unit": _unit.toJson()
    };
  }
}

class DBIngredientUnitModel {
  final String _singular;
  final String _plural;
  final String _unitCategory; // whole, specific, SI
  final String _measurementType; // mass, volume
  final Map<String, double> _conversionFactorTo;

  DBIngredientUnitModel(String singular, String plural, String unitCategory, String measurementType, Map<String, dynamic> conversionFactorTo) :
      this._singular = singular,
      this._plural = plural,
      this._unitCategory = unitCategory,
      this._measurementType = measurementType,
      this._conversionFactorTo = conversionFactorTo;

  String get singular => _singular;

  String get plural => _plural;

  String get unitCategory => unitCategory;

  String get measurementType => _measurementType;

  Map<String, double> get conversionFactorTo => {..._conversionFactorTo};

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
      "singular": _singular,
      "plural": _plural,
      "unitCategory": _unitCategory,
      "measurementType": _measurementType,
      "conversionFactorTo": _conversionFactorTo
    };
  }
}
