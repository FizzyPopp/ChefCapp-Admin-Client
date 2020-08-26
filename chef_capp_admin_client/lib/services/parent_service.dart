import 'package:chef_capp_admin_client/index.dart';

class ParentService {
  static AuthService _authService;
  static DatabaseService _databaseService;

  static AuthService get auth {
    if (_authService == null) {
      _authService = AuthService();
    }
    return _authService;
  }

  static DatabaseService get database {
    if (_databaseService == null) {
      _databaseService = DatabaseService();
    }
    return _databaseService;
  }
}