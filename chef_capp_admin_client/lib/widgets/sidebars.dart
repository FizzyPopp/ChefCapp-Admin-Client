import 'package:chef_capp_admin_client/index.dart';

class MainSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: ListView(
        children: [
          SizedBox(height: xMargins,),
          ListTile(
            enabled: true,
            title: Text('Recipes'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: RecipesHome()),
              );
            },
          ),
          ListTile(
            enabled: true,
            title: Text('Ingredients'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: IngredientsHome()),
              );
            },
          ),
          ListTile(
            enabled: true,
            title: Text('Measurement units'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: MeasurementUnitsHome()),
              );
            },
          ),
        ],
      ),
    );
  }
}
