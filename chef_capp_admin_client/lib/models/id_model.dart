import 'package:chef_capp_admin_client/index.dart';
part 'id_model.g.dart';

@JsonSerializable()
class IDModel implements EqualsInterface {
  final String _value;

  IDModel(String value) :
        this._value = value;

  IDModel.random() : this._value = genUUID();

  static String genUUID() {
    return Uuid().v4();
  }

  String get value => _value;

  @override
  String toString() => _value;

  bool equals(var other) {
    if (other is! IDModel) return false;
    return other.value == this.value;
  }

  factory IDModel.fromJson(Map<String, dynamic> json) => _$IDModelFromJson(json);

  Map<String, dynamic> toJson() => _$IDModelToJson(this);
}