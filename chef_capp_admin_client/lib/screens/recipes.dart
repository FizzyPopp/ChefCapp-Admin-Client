import 'dart:html';

import 'package:chef_capp_admin_client/index.dart';

class RecipesHome extends StatelessWidget {
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
                                child: Text('Recipes'),
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                          RaisedButton(
                            child: Text('ADD NEW RECIPE'),
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
                                'Recipe Name'
                            ),
                          ),
                          DataColumn(
                            label: Text(
                                'Publishing Status'
                            ),
                          ),
                        ],
                        showCheckboxColumn: false,
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('00001')),
                              DataCell(Text('Cheesy Soufflé Omelette')),
                              DataCell(Text('Published')),
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
                              DataCell(Text('Classic Beef Burger')),
                              DataCell(Text('Saved')),
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

class RecipePage extends StatelessWidget {
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
                                child: Text('Recipes'),
                                onPressed: () {

                                },
                              ),
                              Text('>'),
                              FlatButton(
                                child: Text('00001'),
                                onPressed: null,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FlatButton(
                                child: Text('CANCEL'),
                                onPressed: () {

                                },
                              ),
                              SizedBox(width: xMargins / 2,),
                              OutlineButton(
                                child: Text('SAVE'),
                                onPressed: () {

                                },
                              ),
                              SizedBox(width: xMargins / 2,),
                              RaisedButton(
                                child: Text('PUBLISH'),
                                onPressed: () {

                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: xMargins,
                        vertical: xMargins / 2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: xMargins,
                          vertical: xMargins,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text('OVERVIEW - ID 00001'),
                            SizedBox(height: xMargins,),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Recipe Name',
                              ),
                            ),
                            SizedBox(height: xMargins,),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Yield',
                              ),
                            ),
                            SizedBox(height: xMargins,),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Prep time',
                                      suffix: Text('mins'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: xMargins,),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Cook time',
                                      suffix: Text('mins'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: xMargins,),
                            Text('INGREDIENTS'),
                            SizedBox(height: xMargins,),
                            Text('DIRECTIONS'),
                            SizedBox(height: xMargins,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                                  child: Text('Step 1'),
                                ),
                                SizedBox(width: xMargins,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RaisedButton(
                                        child: Text('Add Ingredient'),
                                        onPressed: null,
                                      ),
                                      TextField(
                                        minLines: 3,
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RaisedButton(
                              child: Text('ADD STEP'),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
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
