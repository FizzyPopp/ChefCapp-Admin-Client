import 'package:chef_capp_admin_client/index.dart';
import 'package:provider/provider.dart';

class IngredientsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBIngredientListController>(
      create: (_) => DBIngredientListController(),
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
                            Consumer<DBIngredientListController>(
                              builder: (context, controller, _) {
                                return RaisedButton(
                                  child: Text('ADD NEW INGREDIENT'),
                                  onPressed: () {
                                    controller.onAddNew(context);
                                  },
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
                        child: Consumer<DBIngredientListController>(
                            builder: (context, controller, _) {
                          return DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text('ID'),
                              ),
                              DataColumn(
                                label: Text('Name (Singular)'),
                              ),
                              DataColumn(
                                label: Text('Category'),
                              ),
                            ],
                            showCheckboxColumn: false,
                            rows: buildList(context, controller),
                          );
                        }),
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

  List<DataRow> buildList(
      BuildContext context, DBIngredientListController controller) {
    return controller.ingredients.map((m) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(m.id.toString())),
          DataCell(Text(m.name)),
          DataCell(Text(m.category)),
        ],
        onSelectChanged: (x) {
          controller.onEdit(context, m);
        },
      );
    }).toList();
  }
}

class IngredientAdd extends StatelessWidget {
  final DBIngredientController controller;

  IngredientAdd(this.controller);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
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
                    child: Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          initialValue: controller.name,
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
                    child: Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          initialValue: controller.tag,
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
                    child: Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          initialValue: controller.plural,
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
                    child: Consumer<DBIngredientController>(
                        builder: (context, controller, _) {
                      return DropdownButtonFormField<int>(
                        value: 0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: toDropMenuItems(controller.categoryOptions),
                        onChanged: (int x) {
                          controller.categoryChanged(x);
                        },
                      );
                    }),
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
                    child: Consumer<DBIngredientController>(
                        builder: (context, controller, _) {
                      return DropdownButtonFormField<int>(
                        value: 0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items:
                            toDropMenuItems(controller.measurementTypeOptions),
                        onChanged: (int x) {
                          controller.measurementTypeChanged(x);
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<DBIngredientController>(
                        builder: (context, controller, _) {
                      return DropdownButtonFormField<int>(
                        value: 0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: toDropMenuItems(controller.cookingUnitOptions),
                        onChanged: (int x) {
                          controller.cookingUnitChanged(x);
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<DBIngredientController>(
                        builder: (context, controller, _) {
                      return DropdownButtonFormField<int>(
                        value: 0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: toDropMenuItems(controller.portionUnitOptions),
                        onChanged: (int x) {
                          controller.portionUnitChanged(x);
                        },
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<DBIngredientController>(
                          builder: (context, controller, _) {
                        return RaisedButton(
                          child: Text('Delete Ingredient'),
                          onPressed: () {
                            controller.onDelete(context);
                          },
                        );
                      }),
                      SizedBox(
                        width: xMargins,
                      ),
                      Consumer<DBIngredientController>(
                          builder: (context, controller, _) {
                        return RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            controller.onSave(context);
                          },
                        );
                      }),
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

  List<DropdownMenuItem<int>> toDropMenuItems(List<String> options) {
    List<DropdownMenuItem<int>> out = [];
    for (int i = 0; i < options.length; i++) {
      out.add(DropdownMenuItem(
        value: i,
        child: Text(options[i]),
      ));
    }
    return out;
  }
}
