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
                                  Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return FlatButton(
                                        child: Text('Recipes'),
                                        onPressed: () {
                                          print(
                                              "breadcrumb: go back to list of recipes page");
                                          controller.onRecipesCrumb(context);
                                        },
                                      );
                                    },
                                  ),
                                  Text('>'),
                                  Consumer<RecipeController>(
                                      builder: (context, controller, _) {
                                    return FlatButton(
                                      child: Text(controller.recipeName),
                                      onPressed: null,
                                    );
                                  })
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
                                  Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return OutlineButton(
                                        child: Text('SAVE'),
                                        onPressed: () {
                                          print(
                                              "save button pressed from recipe edit page");
                                          controller.onSave(context);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: xMargins / 2,
                                  ),
                                  Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return RaisedButton(
                                        child: Text('PUBLISH'),
                                        onPressed: () {
                                          print(
                                              "publish button pressed from recipe edit page");
                                          controller.onPublish(context);
                                        },
                                      );
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
                                Consumer<RecipeController>(
                                  builder: (context, controller, _) {
                                    return Text('OVERVIEW - ID ${controller.id}');
                                  }
                                ),
                                SizedBox(
                                  height: xMargins / 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: xMargins / 2),
                                  child: Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return TextFormField(
                                        initialValue: controller.recipeName,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Recipe Name',
                                        ),
                                        onChanged: (newText) {
                                          controller.recipeNameChanged(newText);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: xMargins / 2),
                                  child: Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return TextFormField(
                                        initialValue: controller.yield,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Yield',
                                        ),
                                        onChanged: (newText) {
                                          controller.yieldChanged(newText);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: xMargins / 2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Consumer<RecipeController>(
                                            builder: (context, controller, _) {
                                          return TextFormField(
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
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        width: xMargins,
                                      ),
                                      Expanded(
                                        child: Consumer<RecipeController>(
                                            builder: (context, controller, _) {
                                          return TextFormField(
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
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                                  child: Text('COVER IMAGE'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: xMargins / 2),
                                  child: Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return RaisedButton(
                                        child: Text('Upload image'),
                                        onPressed: () {
                                          controller.onUploadImage();
                                        },
                                      );
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
                                ...getSteps(),
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> getSteps() {
    List<Widget> out = [];
    for (RecipeStepController rsc in controller.stepControllers) {
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
              child: Text('Step ${controller.step}'),
            ),
            SizedBox(
              width: xMargins,
            ),
            Consumer<RecipeStepController>(
              builder: (context, controller, _) {
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
              }
            ),
            SizedBox(
              width: xMargins,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<RecipeStepController>(
                              builder: (context, controller, _) {
                                return TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Find an ingredient...',
                                    ),
                                    onChanged: (newText) {
                                      controller.findIngredientChanged(newText);
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            width: xMargins,
                          ),
                          Expanded(
                            child: Consumer<RecipeStepController>(
                              builder: (context, controller, _) {
                                return DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items: <DropdownMenuItem>[
                                    DropdownMenuItem(
                                      child: Text('Verbiage'),
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Item'),
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Item'),
                                    ),
                                  ],
                                  onChanged: (x) {
                                    controller.verbiageChanged(x);
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: xMargins,
                          ),
                          Expanded(
                            child: Consumer<RecipeStepController>(
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
                            child: Consumer<RecipeStepController>(
                                builder: (context, controller, _) {
                              return DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text('Unit'),
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Item'),
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Item'),
                                  ),
                                ],
                                onChanged: (x) {
                                  controller.unitChanged(x);
                                },
                              );
                            }),
                          ),
                          SizedBox(width: xMargins,),
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () {

                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: xMargins / 2,
                  ),
                  Consumer<RecipeStepController>(
                      builder: (context, controller, _) {
                    return RaisedButton(
                      child: Text('Add Ingredient'),
                      onPressed: () {
                        print("add ingredient button pressed");
                        controller.addIngredient();
                      },
                    );
                  }),
                  SizedBox(
                    height: xMargins / 2,
                  ),
                  Consumer<RecipeStepController>(
                      builder: (context, controller, _) {
                    return TextFormField(
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
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
