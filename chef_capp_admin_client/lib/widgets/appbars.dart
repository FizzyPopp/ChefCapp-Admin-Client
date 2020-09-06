import 'package:chef_capp_admin_client/index.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final DatabaseService _dbService;

  MainAppBar() : _dbService = DatabaseService();

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
              //_dbService.test();
              //ParentService.testValidate();
              //_auth.test();
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
