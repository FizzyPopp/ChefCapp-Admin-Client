import 'package:chef_capp_admin_client/index.dart';

class StepIngredientModel implements EqualsInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  final IDModel _id;
  final String _name;
  final String _unitCategory; // whole, specific, SI
  final double _quantity;
  final String _unit; // depends on unitCategory

  StepIngredientModel(IDModel id, String name, String unitCategory, double quantity, String unit) :
        this._id = id,
        this._name = name,
        this._unitCategory = unitCategory,
        this._quantity = quantity,
        this._unit = unit;

  IDModel get id => _id;

  String get name => _name;

  String get unitCategory => _unitCategory;

  double get quantity => _quantity;

  String get unit => _unit;

  bool equals(var other) {
    if (other is! StepIngredientModel) return false;
    return (other as StepIngredientModel).id.equals(this.id);
  }

  static StepIngredientModel fromDB(data) {
    return null;
  }
}
