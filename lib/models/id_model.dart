import 'package:chef_capp_admin_client/index.dart';
part 'id_model.g.dart';

@JsonSerializable()
class IDModel implements EqualsInterface {
  final String _value;

  IDModel(String value) :
        this._value = value;

  IDModel.random() : this._value = genUUID();

  IDModel.nil() : this._value = nilUUID();

  String get value => _value;

  @override
  String toString() => _value;

  static String genUUID() {
    return Uuid().v4();
  }

  // use this if new to database
  static String nilUUID() {
    return "00000000-0000-0000-0000-000000000000";
  }

  bool equals(var other) {
    if (other is! IDModel) return false;
    return (other as IDModel).value == this.value;
  }

  factory IDModel.fromJson(Map<String, dynamic> json) => _$IDModelFromJson(json);

  Map<String, dynamic> toJson() => _$IDModelToJson(this);

  static IDModel fromDB(data) {
    return IDModel(data);
  }
}