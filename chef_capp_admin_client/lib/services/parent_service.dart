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

  static testValidate() async {
    //String url = 'http://localhost:3000/validate';
    //String url = 'http://10.0.2.2:3000/validate';

    /*
    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "body text", "userId": 1}';  // make PUT request

    Response response = await put(url, headers: headers, body: json);  // check the status code for the result
    int statusCode = response.statusCode;  // this API passes back the updated item with the id added
    String body = response.body;

    print(body);
    print(statusCode);
     */
  }
}