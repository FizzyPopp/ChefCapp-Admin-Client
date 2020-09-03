import 'package:chef_capp_admin_client/index.dart';
import 'package:provider/provider.dart';

class IngredientsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IngredientController>(
      create: (_) => IngredientController(),
      child: Scaffold(
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
                                  onPressed: null,
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
                        child: Consumer<IngredientController>(
                          builder: (context, controller, _) {
                            return DataTable(
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
                                  print('ingredient edit selected');
                                  controller.onEdit(context);
                                },
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('00002')),
                                  DataCell(Text('Salted Butter')),
                                  DataCell(Text('Dairy')),
                                ],
                                onSelectChanged: (x) {
                                  print('ingredient edit selected');
                                  controller.onEdit(context);
                                },
                              ),
                            ],
                          );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IngredientController>(
      create: (_) => IngredientController(),
      child: Padding(
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
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name (Singular)',
                          ),
                          onChanged: (newText) {
                            controller.ingredientNameChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tag',
                          ),
                          onChanged: (newText) {
                            controller.ingredientTagChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Plural',
                          ),
                          onChanged: (newText) {
                            controller.ingredientPluralChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return DropdownButtonFormField(
                          value: 0,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: toDropMenuItems(controller.categoryOptions),
                          onChanged: (x) {
                            print(x);
                          },
                        );
                      }
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
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return DropdownButtonFormField(
                          value: 0,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: toDropMenuItems(controller.siUnitOptions),
                          onChanged: (x) {
                            print(x);
                          },
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                        builder: (context, controller, _) {
                          return DropdownButtonFormField(
                            value: 0,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: toDropMenuItems(controller.cookingUnitOptions),
                            onChanged: (x) {
                              print(x);
                            },
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                        builder: (context, controller, _) {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: toDropMenuItems(controller.portionUnitOptions),
                            onChanged: (x) {
                              print(x);
                            },
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                        builder: (context, controller, _) {
                          return DropdownButtonFormField(
                            value: 0,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: toDropMenuItems(controller.storageUnitOptions),
                            onChanged: (x) {
                              print(x);
                            },
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<IngredientController>(
                      builder: (context, controller, _) {
                        return DropdownButtonFormField(
                          value: 0,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: toDropMenuItems(controller.bulkUnitOptions),
                          onChanged: (x) {
                            print(x);
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<IngredientController>(
                        builder: (context, controller, _) {
                          return RaisedButton(
                            child: Text('Delete Ingredient'),
                            onPressed: () {
                              controller.onDelete(context);
                            },
                          );
                        }
                      ),
                      SizedBox(width: xMargins,),
                      Consumer<IngredientController>(
                          builder: (context, controller, _) {
                            return RaisedButton(
                              child: Text('Save'),
                              onPressed: () {
                                controller.onSave(context);
                              },
                            );
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<dynamic>> toDropMenuItems(List<String> options) {
    List<DropdownMenuItem<dynamic>> out = [];
    for (int i = 0; i < options.length; i++) {
      out.add(DropdownMenuItem(
        value: i,
        child: Text(options[i]),
      ));
    }
    return out;
  }
}
