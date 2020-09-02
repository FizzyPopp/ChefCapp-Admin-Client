import 'package:chef_capp_admin_client/index.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final AuthService _auth;

  MainAppBar() : _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Chef Capp Admin'),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: xMargins,
            vertical: xMargins / 2,
          ),
          child: RaisedButton(
            child: Text('SIGN IN'),
            onPressed: () {
              _auth.test();
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
