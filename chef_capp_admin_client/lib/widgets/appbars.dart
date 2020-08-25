import 'package:chef_capp_admin_client/index.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
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
            child: Text('SIGN OUT'),
            onPressed: () {

            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
