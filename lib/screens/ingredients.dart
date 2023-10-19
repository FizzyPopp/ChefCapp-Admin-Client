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
          DataCell(Text(m.singular)),
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
    const mockResults = <AppProfile>[
      AppProfile('John Doe', 'jdoe@flutter.io',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      AppProfile('Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      AppProfile('Fred', 'fred@google.com',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Brian', 'brian@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Nelly', 'nelly@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Marie', 'marie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Charlie', 'charlie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Diana', 'diana@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Ernie', 'ernie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Gina', 'fred@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

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
                          key: UniqueKey(),
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
                  /*
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          key: UniqueKey(),
                          initialValue: "",
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tag',
                          ),
                          onChanged: (newText) {
                            //print(newText);
                            //controller.ingredientTagChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                   */
                  /*
                  Consumer<DBIngredientController>(
                    builder: (context, controller, _) {
                      return ChipsInput(
                        allowChipEditing: false,
                        findSuggestions: (String query) {
                          if (query.length != 0) {
                            var lowercaseQuery = query.toLowerCase();
                            return mockResults.where((profile) {
                              return profile.name.toLowerCase().contains(query.toLowerCase()) || profile.email.toLowerCase().contains(query.toLowerCase());
                            }).toList(growable: false)
                              ..sort((a, b) => a.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)
                                  .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));
                          } else {
                            return const <AppProfile>[];
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Tags",
                        ),
                        maxChips: 3,
                        onChanged: (List<dynamic> data) {
                          data = data.map((d) => d.toString()).toList();
                          controller.ingredientTagsChanged(data);
                        },
                        chipBuilder: (context, state, profile) {
                          return InputChip(
                            key: ObjectKey(profile),
                            label: Text(profile.name),
                            avatar: CircleAvatar(
                              backgroundImage: NetworkImage(profile.imageUrl),
                            ),
                            onDeleted: () => state.deleteChip(profile),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          );
                        },
                        suggestionBuilder: (context, state, profile) {
                          return ListTile(
                            key: ObjectKey(profile),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(profile.imageUrl),
                            ),
                            title: Text(profile.name),
                            subtitle: Text(profile.email),
                            onTap: () => state.selectSuggestion(profile),
                          );
                        },
                      );
                    }
                  ),
                   */
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          key: UniqueKey(),
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
                        key: UniqueKey(),
                        value: controller.category,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Category',
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
                      'Cooking unit',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Consumer<DBIngredientController>(
                      builder: (context, controller, _) {
                        return IngredientUnitRow(controller.units["cooking"]);
                      }
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Text(
                      'Portion unit',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Consumer<DBIngredientController>(
                    builder: (context, controller, _) {
                      return IngredientUnitRow(controller.units["portion"]);
                    }
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

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppProfile &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

class IngredientUnitRow extends StatelessWidget {
  final DBIngredientUnitController controller;

  IngredientUnitRow(this.controller);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Row(children: [
          Expanded(
            child: Consumer<DBIngredientUnitController>(
              builder: (context, controller, _) {
                return TextFormField(
                  key: UniqueKey(),
                  initialValue: controller.singular,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'singular',
                  ),
                  onChanged: (newText) {
                    controller.singularChanged(newText);
                  },
                );
              }
            ),
          ),
          SizedBox(
            width: xMargins,
          ),
          Expanded(
              child: Consumer<DBIngredientUnitController>(
                builder: (context, controller, _) {
                  return TextFormField(
                    key: UniqueKey(),
                    initialValue: controller.plural,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'plural',
                    ),
                    onChanged: (newText) {
                      controller.pluralChanged(newText);
                    },
                  );
                }
              )
          ),
          SizedBox(
            width: xMargins,
          ),
          Expanded(
              child: Consumer<DBIngredientUnitController>(
                  builder: (context, controller, _) {
                    return DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      value: controller.measurementType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: DBIngredientUnitModel.measurementTypeOptions.map<DropdownMenuItem<String>>((s) =>
                          DropdownMenuItem<String>(
                            value: s,
                            child: Text(s),
                          )).toList(),
                      onChanged: (String x) {
                        controller.measurementTypeChanged(x);
                      },
                    );
                  }
              )
          ),
          SizedBox(
            width: xMargins,
          ),
          Expanded(
              child: Consumer<DBIngredientUnitController>(
                  builder: (context, controller, _) {
                    return DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      value: controller.unitCategory,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: DBIngredientUnitModel.unitCategoryOptions.map<DropdownMenuItem<String>>((s) =>
                          DropdownMenuItem<String>(
                            value: s,
                            child: Text(s),
                          )).toList(),
                      onChanged: (String x) {
                        controller.unitCategoryChanged(x);
                      },
                    );
                  }
              )
          ),
          SizedBox(
            width: xMargins,
          ),
          Expanded(
              child: Consumer<DBIngredientUnitController>(
                builder: (context, controller, _) {
                  return TextFormField(
                    key: UniqueKey(),
                    initialValue: controller.conversionFactorTo.toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Conversion Factor',
                    ),
                    onChanged: (String newText) {
                      controller.conversionFactorToChanged(newText);
                    },
                  );
                }
              )
          ),
        ])
    );
  }
}
