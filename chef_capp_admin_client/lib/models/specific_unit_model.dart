import 'package:chef_capp_admin_client/index.dart';

class SpecificUnitModel implements EqualsInterface {
  final String _singular;
  final String _plural;
  final List<IDModel> _usedIn;

  SpecificUnitModel(String singular, String plural, List<IDModel> usedIn) :
        this._singular = singular,
        this._plural = plural,
        this._usedIn = usedIn;

  String get singular => _singular;

  String get plural => _plural;

  List<IDModel> get usedIn => [..._usedIn];

  bool equals(var other) {
    if (other is! SpecificUnitModel) return false;
    other = (other as SpecificUnitModel);
    // SHOULD ALSO CHECK USEDIN
    return other.singular == this.singular && other.plural == this.plural;
  }

  @override
  String toString() {
    return _singular;
  }

  static SpecificUnitModel fromDB(String key, Map<String, dynamic> data) {
    List<IDModel> usedIn = [];

    if (data.containsKey("usedIn")) {
      usedIn = data["usedIn"].map<IDModel>((id) => IDModel(id)).toList();
    }

    return SpecificUnitModel(key, data["plural"], usedIn);
  }

  Map<String, dynamic> toJson() {
    List<String> usedIn = _usedIn.map<String>((id) => id.toString()).toList();
    return {
      _singular: {
        "plural": _plural,
        "usedIn": usedIn
      }
    };
  }
}