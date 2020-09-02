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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: xMargins),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: xMargins,
                        //vertical: xMargins / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FlatButton(
                                //padding: EdgeInsets.symmetric(horizontal: 0.0),
                                child: Text('Measurement Units'),
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                          RaisedButton(
                            child: Text('ADD NEW UNIT'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => MeasurementUnitsAdd(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: xMargins,
                        vertical: xMargins / 2,
                      ),
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                                'Unit'
                            ),
                          ),
                        ],
                        showCheckboxColumn: false,
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Clove')),
                            ],
                            onSelectChanged: (x) {

                            },
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Sprig')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeasurementUnitsAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
