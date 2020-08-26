import 'package:chef_capp_admin_client/index.dart';

class IngredientsHome extends StatelessWidget {
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
                                child: Text('Ingredients'),
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                          RaisedButton(
                            child: Text('ADD NEW INGREDIENT'),
                            onPressed: () {

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
                                'ID'
                            ),
                          ),
                          DataColumn(
                            label: Text(
                                'Name (Singular)'
                            ),
                          ),
                          DataColumn(
                            label: Text(
                                'Category'
                            ),
                          ),
                        ],
                        showCheckboxColumn: false,
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('00001')),
                              DataCell(Text('Unsalted butter')),
                              DataCell(Text('Diary')),
                            ],
                            onSelectChanged: (x) {
                              Navigator.push(
                                context,
                                FadeRoute(page: RecipePage()),
                              );
                            },
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('00002')),
                              DataCell(Text('Salted Butter')),
                              DataCell(Text('Dairy')),
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