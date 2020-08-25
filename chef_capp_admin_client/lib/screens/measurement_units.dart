import 'package:chef_capp_admin_client/index.dart';

class MeasurementUnitsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainSideBar(),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: xMargins,
                      vertical: xMargins,
                    ),
                    child: Card(
                      child: Center(
                        child: Text('Measurement Units Home'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
