import 'dart:html';

import 'package:chef_capp_admin_client/index.dart';
import 'package:provider/provider.dart';

enum directionsPopupOptions { firstOpt, secondOpt, thirdOpt, fourthOpt }

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
                                onPressed: () {},
                              )
                            ],
                          ),
                          RaisedButton(
                            child: Text('ADD NEW RECIPE'),
                            onPressed: () {},
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
                                FadeRoute(page: RecipePage(false)),
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
  final bool isNew;

  RecipePage(this.isNew);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeController>(
        create: (_) => RecipeController(),
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
                                  FlatButton(
                                    child: Text('00001'),
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
                                Text('OVERVIEW - ID 00001'),
                                SizedBox(
                                  height: xMargins / 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: xMargins / 2),
                                  child: Consumer<RecipeController>(
                                    builder: (context, controller, _) {
                                      return TextField(
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
                                      return TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Yield',
                                          ),
                                          onChanged: (newText) {
                                            controller.yieldChanged(newText);
                                          });
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
                                          return TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Prep time',
                                                suffix: Text('mins'),
                                              ),
                                              onChanged: (newText) {
                                                controller
                                                    .prepTimeChanged(newText);
                                              });
                                        }),
                                      ),
                                      SizedBox(
                                        width: xMargins,
                                      ),
                                      Expanded(
                                        child: Consumer<RecipeController>(
                                            builder: (context, controller, _) {
                                          return TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Cook time',
                                                suffix: Text('mins'),
                                              ),
                                              onChanged: (newText) {
                                                controller
                                                    .cookTimeChanged(newText);
                                              });
                                        }),
                                      ),
                                    ],
                                  ),
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
                                Consumer<RecipeController>(
                                  builder: (context, controller, _) {
                                    // NO! going to have to rethink this section
                                    // multiple recipe steps need to be displayed
                                    return RecipeStep(
                                        controller.newStepController());
                                  },
                                ),
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
              child: Text('Step 1'),
            ),
            SizedBox(
              width: xMargins,
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<directionsPopupOptions>>[
                const PopupMenuItem<directionsPopupOptions>(
                  value: directionsPopupOptions.firstOpt,
                  child: Text('Move up'),
                ),
                const PopupMenuItem<directionsPopupOptions>(
                  value: directionsPopupOptions.secondOpt,
                  child: Text('Move down'),
                ),
                const PopupMenuItem<directionsPopupOptions>(
                  value: directionsPopupOptions.secondOpt,
                  child: Text('Delete step'),
                ),
              ],
              onSelected: (x) {
                print(x);
              },
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
                              }
                            ),
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
                    }
                  ),
                  SizedBox(
                    height: xMargins / 2,
                  ),
                  Consumer<RecipeStepController>(
                    builder: (context, controller, _) {
                      return TextField(
                        minLines: 3,
                        maxLines: 8,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write your step directions here...'),
                        onChanged: (newText) {
                          controller.stepDirectionsChanged(newText);
                        },
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
