import 'package:chef_capp_admin_client/index.dart';

class ID implements EqualsInterface {
  final String _hash;

  ID(String hash) :
        this._hash = hash;

  String get hash => _hash;

  @override
  String toString() => _hash;

  bool equals(var other) {
    if (other is! ID) return false;
    return other.hash == this.hash;
  }
}