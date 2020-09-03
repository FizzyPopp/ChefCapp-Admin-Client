import 'package:chef_capp_admin_client/index.dart';

class StepIngredientModel implements EqualsInterface, IngredientInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  final IDModel _id;
  final String _name;
  final String _plural;
  final double _quantity;
  final String _unit;
  final String _category;
  final List<double> _range;

  StepIngredientModel(IDModel id, String name, String plural, double quantity, String unit, String category) :
        this._id = id,
        this._name = name,
        this._plural = plural,
        this._quantity = quantity,
        this._unit = unit,
        this._category = category,
        this._range = [quantity, quantity];

  StepIngredientModel.fromZero(DBIngredientModel zi, double quantity) :
      this._id = zi.id,
      this._name = zi.name,
      this._plural = zi.plural,
      this._quantity = quantity,
      this._unit = zi.unit,
      this._category = zi.category,
      this._range = [quantity, quantity];

  IDModel get id => _id;

  String get name => _name;

  String get plural => _plural;

  double get quantity => _quantity;

  String get unit => _unit;

  String get category => _category;

  List<double> get range => [..._range];

  bool equals(var other) {
    if (other is! StepIngredientModel) return false;
    return this.id == other.id;
  }

  String get amount {
    String out;
    if (_quantity == 0) {
      return "";
    } else {
      out = "${doubleToMixedFraction(_quantity)}$_unit";
    }
    return out;
  }

  static String doubleToMixedFraction (double v) {
    int whole = v.floor();
    int numerator = ((v - whole) * 12).round();

    String fraction = "";

    switch (numerator) {
      case 0:
      // round down
        return "$whole";
      case 1:
      // round down
        return "$whole";
        break;
      case 2:
      // round up
        fraction = "\u00BC";
        break;
      case 3:
      // 3/12 = one quarter
        fraction = "\u00BC";
        break;
      case 4:
      // 4/12 = one third
        fraction = "\u2153";
        break;
      case 5:
      // round up
        fraction = "\u00BD";
        break;
      case 6:
      // 6/12 = one half
        fraction = "\u00BD";
        break;
      case 7:
      // round down
        fraction = "\u00BD";
        break;
      case 8:
      // 8/12 = two thirds
        fraction = "\u2154";
        break;
      case 9:
      // 9/12 = three quarters
        fraction = "\u00BE";
        break;
      case 10:
      // round down
        fraction = "\u00BE";
        break;
      case 11:
      // round up
        return "${whole + 1}";
      case 12:
      // round up
        return "${whole + 1}";
      default:
        throw ("bad conversion to mixed fraction");
    }

    if (whole == 0) {
      return fraction;
    } else {
      return "$whole" + fraction;
    }
  }

  static StepIngredientModel fromDB(data) {
    print("check 1");

    // sanitize
    if (data["id"] == null || data["id"] == "") {
      throw ("bad id");
    }
    if (data["name"] == null ||
        data["name"] is! Map ||
        data["name"]["singular"] == null ||
        data["name"]["singular"] == "") {
      throw ("bad name");
    }
    if (data["quantity"] == null || data["quantity"] == "") {
      data["quantity"] = 0;
    }
    if (data["unit"] == null) {
      throw ("bad unit");
    }

    print("check 2");

    // parse
    double quantity = data["quantity"].toDouble();
    String unit = data["unit"];
    String name = data["name"]["singular"];
    String plural = (data["name"]["plural"] ?? name);

    print("check 3");

    // TODO: get category

    // return
    return StepIngredientModel(IDModel(data["id"]), name, plural, quantity, unit, "A Category");
  }

  static List<StepIngredientModel> listFromDB(data) {
    if (data.isEmpty) {
      return [];
    }

    List<String> keys;
    List<StepIngredientModel> unsortedIngredients = [];
    // get keys and parse ingredients
    data.forEach((k, v) {
      if (k == "keys") {
        keys = List<String>.from(v);
      } else {
        unsortedIngredients.add(StepIngredientModel.fromDB(v));
      }
    });
    // sanitize
    if (keys == null) {
      throw("no keys for ingredients");
    }
    // order ingredients
    List<StepIngredientModel> ingredients = [];
    for (int k = 0; k < keys.length; k++) {
      for (int i = 0; i < unsortedIngredients.length; i++) {
        if (unsortedIngredients[i].id.toString() == keys[k]) {
          ingredients.add(unsortedIngredients.removeAt(i));
          break;
        }
      }
    }
    // sanitize
    if (ingredients.length != keys.length) {
      throw ("ingredient keys do not match actual ingredients");
    }
    return ingredients;
  }
}
