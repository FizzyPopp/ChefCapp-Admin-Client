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
                                        controller.onSave(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: xMargins / 2,
                                    ),
                                    RaisedButton(
                                      child: Text('PUBLISH'),
                                      onPressed: () {
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
                                        controller.newStep();
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
                        initialValue: controller.instructions,
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
          child: Row(children: [
              Expanded(
                child: AutoField(rsic),
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
                      items: DBIngredientUnitModel.unitCategoryOptions
                          .map<DropdownMenuItem<String>>((s) =>
                              DropdownMenuItem<String>(
                                  value: s, child: Text(s)))
                          .toList(),
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
                    return TextFormField(
                      key: UniqueKey(),
                      initialValue: controller.quantity,
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
                  return DropdownButtonFormField<int>(
                    key: UniqueKey(),
                    value: controller.unit,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: controller.unitOptions.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value)
                      );
                    }).toList(),
                    onChanged: (int x) {
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
            ])
        ),
      );
    }

    return out;
  }
}

class AutoField extends StatefulWidget {

  final RecipeStepIngredientController controller;

  AutoField(this.controller);

  @override
  _AutoFieldState createState() => _AutoFieldState(controller);
}

class _AutoFieldState extends State<AutoField> {

  final RecipeStepIngredientController controller;

  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  _AutoFieldState(this.controller);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {

        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);

      } else {
        this._overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: ChangeNotifierProvider.value(
              value: controller.optionsController,
              child: Material(
                  elevation: 4.0,
                  child: Consumer<IngredientOptionsController>(
                    builder: (context, controller, _) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: buildOptions(context, controller),
                      );
                    }
                  ),
                )
            ),
          ),
        )
    );
  }

  List<Widget> buildOptions(BuildContext context, IngredientOptionsController controller) {
    List<Widget> out = [];
    for (DBIngredientModel m in controller.options) {
      out.add(ListTile(
        title: Text(m.singular),
        onTap: () {
          controller.ingredientOptionTapped(m);
        },
      ));
    }

    out.add(ListTile(
      //tileColor: Colors.green,
      leading: Icon(Icons.add),
      title: Text(
        'add new',
        style: TextStyle(
            color: Colors.green
        ),
      ),
      onTap: () {
        controller.onAddNew(context);
      },
    ));

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Consumer<RecipeStepIngredientController>(
        builder: (context, controller, _) {
          return TextFormField(
            key: UniqueKey(),
            controller: controller.fieldController,
            focusNode: this._focusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Find an ingredient...',
            ),
            onChanged: (newText) {
              controller.searchIngredients(newText);
            }
          );
        }
      ),
    );
  }
}