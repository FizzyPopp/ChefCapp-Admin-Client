import 'package:chef_capp_admin_client/index.dart';

class SpecificUnitModel implements EqualsInterface {
  final String singular;
  final String plural;
  List<IDModel> _usedIn;

  SpecificUnitModel(String singular, String plural, List<IDModel> usedIn) :
        this.singular = singular,
        this.plural = plural,
        this._usedIn = [...usedIn];

  List<IDModel> get usedIn => [..._usedIn];

  set usedIn(List<IDModel> usedIn) => _usedIn = [...usedIn];

  bool equals(var other) {
    if (other is! SpecificUnitModel) return false;
    other = (other as SpecificUnitModel);
    // SHOULD ALSO CHECK USEDIN
    return other.singular == this.singular && other.plural == this.plural;
  }

  @override
  String toString() {
    return singular;
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
      singular: {
        "plural": plural,
        "usedIn": _usedIn
      }
    };
  }
}