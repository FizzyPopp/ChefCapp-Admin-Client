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
                              showDialog(
                                context: context,
                                builder: (_) => IngredientAdd(),
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

class IngredientAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: xMargins,
              vertical: xMargins / 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: Text(
                    'Add Ingredient',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name (Singular)',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tag',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Plural',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('Category'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: Text(
                    'Unit Data for Ingredient',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('SI unit'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('Cooking unit'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('Portion unit'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('Storage unit'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('Bulk unit'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                      DropdownMenuItem(
                        child: Text('Item'),
                      ),
                    ],
                    onChanged: (x) {

                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: Text('Delete Ingredient'),
                      onPressed: () {

                      },
                    ),
                    SizedBox(width: xMargins,),
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
