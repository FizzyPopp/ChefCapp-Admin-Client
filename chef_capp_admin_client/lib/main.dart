import 'package:chef_capp_admin_client/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Chef Capp Admin';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => App(),
      },
    );
  }
}
