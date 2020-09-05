import 'package:chef_capp_admin_client/index.dart';

class DBIngredientModel implements EqualsInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  final IDModel _id;
  final String _name;
  final String _plural;
  final Map<String, dynamic> _unit;
  final String _category;

  DBIngredientModel(IDModel id, String name, String plural, Map<String, dynamic> unit, String category) :
        this._id = id,
        this._name = name,
        this._plural = plural,
        this._unit = unit,
        this._category = category;

  IDModel get id => _id;

  String get name => _name;

  String get plural => _plural;

  String get unit => _unit["singular"];

  String get category => _category;

  bool equals(var other) {
    if (other is! DBIngredientModel) return false;
    return this.id == other.id;
  }

  String get amount {
    return "0$_unit";
  }

  static DBIngredientModel fromDB(data) {
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
    if (data["unit"] == null) {
      throw ("bad unit");
    }

    // parse
    Map unit = data["unit"];
    String name = data["name"]["singular"];
    String plural = (data["name"]["plural"] ?? name);

    // TODO: get category

    // return
    return DBIngredientModel(IDModel(data["id"]), name, plural, unit, "A Category");
  }
}
