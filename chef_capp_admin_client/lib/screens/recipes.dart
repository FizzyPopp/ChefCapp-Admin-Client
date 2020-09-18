import 'dart:html';

import 'package:chef_capp_admin_client/index.dart';
import 'package:provider/provider.dart';

enum stepPopupOptions { firstOpt, secondOpt, thirdOpt, fourthOpt }

class RecipesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeListController>(
        create: (_) => RecipeListController(),
        builder: (context, snapshot) {
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
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                                Consumer<RecipeListController>(
                                  builder: (context, controller, _) {
                                    return RaisedButton(
                                      child: Text('ADD NEW RECIPE'),
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
                            child: Consumer<RecipeListController>(
                                builder: (context, controller, _) {
                              return DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text('ID'),
                                  ),
                                  DataColumn(
                                    label: Text('Recipe Name'),
                                  ),
                                  DataColumn(
                                    label: Text('Publishing Status'),
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
          );
        });
  }

  List<DataRow> buildList(
      BuildContext context, RecipeListController controller) {
    return controller.recipes.map((m) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(m.id.toString())),
          DataCell(Text(m.title)),
          DataCell(Text(m.status)),
        ],
        onSelectChanged: (x) {
          controller.onEdit(context, m);
        },
      );
    }).toList();
  }
}

class RecipePage extends StatelessWidget {
  final RecipeController controller;

  RecipePage(this.controller);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: controller,
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
                    child: Consumer<RecipeController>(
                        builder: (context, controller, _) {
                      return ListView(
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
                                      child: Text('Recipes'),
                                      onPressed: () {
                                        print(
                                            "breadcrumb: go back to list of recipes page");
                                        controller.onRecipesCrumb(context);
                                      },
                                    ),
                                    Text('>'),
                                    FlatButton(
                                      child: Text(controller.recipeName),
                                      onPressed: null,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Consumer<RecipeController>(
                                      builder: (context, controller, _) {
                                        return FlatButton(
                                          child: Text('CANCEL'),
                                          onPressed: () {
                                            print(
                                                "cancel: go back to list of recipes page");
                                            controller.onCancel(context);
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: xMargins / 2,
                                    ),
                                    OutlineButton(
                                      child: Text('SAVE'),
                                      onPressed: () {
                                        print(
                                            "save button pressed from recipe edit page");
                                        controller.onSave(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: xMargins / 2,
                                    ),
                                    RaisedButton(
                                      child: Text('PUBLISH'),
                                      onPressed: () {
                                        print(
                                            "publish button pressed from recipe edit page");
                                        controller.onPublish(context);
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
                                  Text('OVERVIEW - ID ${controller.id}'),
                                  SizedBox(
                                    height: xMargins / 2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      initialValue: controller.recipeName,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Recipe Name',
                                      ),
                                      onChanged: (newText) {
                                        controller.recipeNameChanged(newText);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: TextFormField(
                                      key: UniqueKey(),
                                      initialValue: controller.yield,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Yield',
                                      ),
                                      onChanged: (newText) {
                                        controller.yieldChanged(newText);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            key: UniqueKey(),
                                            initialValue: controller.prepTime,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Prep time',
                                              suffix: Text('mins'),
                                            ),
                                            onChanged: (newText) {
                                              controller
                                                  .prepTimeChanged(newText);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: xMargins,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            key: UniqueKey(),
                                            initialValue: controller.cookTime,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cook time',
                                              suffix: Text('mins'),
                                            ),
                                            onChanged: (newText) {
                                              controller
                                                  .cookTimeChanged(newText);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: Text('COVER IMAGE'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: RaisedButton(
                                      child: Text('Upload image'),
                                      onPressed: () {
                                        controller.onUploadImage();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: Text('INGREDIENTS'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: Text('DIRECTIONS'),
                                  ),
                                  ...getSteps(context, controller),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: xMargins / 2),
                                    child: RaisedButton(
                                      child: Text('ADD STEP'),
                                      onPressed: () {
                                        print(
                                            "add step button pressed on recipe edit page");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> getSteps(BuildContext context, RecipeController controller) {
    List<Widget> out = [];
    for (RecipeStepController rsc in controller.steps) {
      var tmp = Consumer<RecipeController>(
        builder: (context, controller, _) {
          return RecipeStep(rsc);
        },
      );
      out.add(tmp);
    }
    return out;
  }
}

class RecipeStep extends StatelessWidget {
  final RecipeStepController controller;

  RecipeStep(this.controller);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: xMargins / 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 12.0, 0, 0),
              child: Consumer<RecipeStepController>(
                builder: (context, controller, _) {
                  return Text('Step ${controller.step}');
                },
              ),
            ),
            SizedBox(
              width: xMargins,
            ),
            Consumer<RecipeStepController>(builder: (context, controller, _) {
              return PopupMenuButton(
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<stepPopupOptions>>[
                  const PopupMenuItem<stepPopupOptions>(
                    value: stepPopupOptions.firstOpt,
                    child: Text('Move up'),
                  ),
                  const PopupMenuItem<stepPopupOptions>(
                    value: stepPopupOptions.secondOpt,
                    child: Text('Move down'),
                  ),
                  const PopupMenuItem<stepPopupOptions>(
                    value: stepPopupOptions.thirdOpt,
                    child: Text('Delete step'),
                  ),
                ],
                onSelected: (stepPopupOptions x) {
                  controller.onStepAction(x);
                },
              );
            }),
            SizedBox(
              width: xMargins,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<RecipeStepController>(
                      builder: (context, controller, _) {
                    return Column(
                      children: buildStepIngredients(context, controller),
                    );
                  }),
                  SizedBox(
                    height: xMargins / 2,
                  ),
                  Consumer<RecipeStepController>(
                      builder: (context, controller, _) {
                    return RaisedButton(
                      child: Text('Add Ingredient'),
                      onPressed: () {
                        print("add ingredient button pressed");
                        controller.onAddIngredient();
                      },
                    );
                  }),
                  SizedBox(
                    height: xMargins / 2,
                  ),
                  Consumer<RecipeStepController>(
                    builder: (context, controller, _) {
                      return TextFormField(
                        key: UniqueKey(),
                        minLines: 3,
                        maxLines: 8,
                        initialValue: controller.directions,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write your step directions here...'),
                        onChanged: (newText) {
                          controller.stepDirectionsChanged(newText);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildStepIngredients(
      BuildContext context, RecipeStepController controller) {
    List<Widget> out = [];
    for (RecipeStepIngredientController rsic in controller.ingredients) {
      out.add(
        ChangeNotifierProvider.value(
          value: rsic,
          builder: (context, snapshot) {
            return Row(children: [
              Expanded(
                child: Consumer<RecipeStepIngredientController>(
                  builder: (context, controller, _) {
                    return TextFormField(
                        key: UniqueKey(),
                        initialValue: controller.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Find an ingredient...',
                        ),
                        onChanged: (newText) {
                          controller.searchIngredients(newText);
                        });
                  },
                ),
              ),
              SizedBox(
                width: xMargins,
              ),
              Expanded(
                child: Consumer<RecipeStepIngredientController>(
                  builder: (context, controller, _) {
                    // if no options, display a fake option?
                    return DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      value: controller.unitCategory,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: RecipeStepIngredientController.unitCategories.map<DropdownMenuItem<String>>(
                              (s) => DropdownMenuItem<String>(
                                  value: s,
                                  child: Text(s)
                              )).toList(),
                      onChanged: (String x) {
                        controller.unitCategoryChanged(x);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: xMargins,
              ),
              Expanded(
                child: Consumer<RecipeStepIngredientController>(
                  builder: (context, controller, _) {
                    return TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                      ),
                      onChanged: (newText) {
                        controller.quantityChanged(newText);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: xMargins,
              ),
              Expanded(
                child: Consumer<RecipeStepIngredientController>(
                    builder: (context, controller, _) {
                  return DropdownButtonFormField<String>(
                    key: UniqueKey(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: "Unit",
                        child: Text("Unit"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Item 2",
                        child: Text('Item 2'),
                      ),
                      DropdownMenuItem<String>(
                        value: "Item 3",
                        child: Text('Item 3'),
                      ),
                    ],
                    onChanged: (String x) {
                      controller.unitChanged(x);
                    },
                  );
                }),
              ),
              SizedBox(
                width: xMargins,
              ),
              Consumer<RecipeStepIngredientController>(
                builder: (context, controller, _) {
                  return IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.onDelete();
                    },
                  );
                },
              ),
            ]);
          },
        ),
      );
    }

    return out;
  }
}