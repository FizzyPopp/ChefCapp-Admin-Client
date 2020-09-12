import 'package:chef_capp_admin_client/index.dart';
part 'specific_unit_model.g.dart';

@JsonSerializable()
class SpecificUnitModel implements EqualsInterface {
  final String _value;

  SpecificUnitModel(String value) : this._value = value;

  String get value => _value;

  bool equals(var other) {
    if (other is! SpecificUnitModel) return false;
    return other.value == this.value;
  }

  factory SpecificUnitModel.fromJson(Map<String, dynamic> json) => _$SpecificUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificUnitModelToJson(this);
}