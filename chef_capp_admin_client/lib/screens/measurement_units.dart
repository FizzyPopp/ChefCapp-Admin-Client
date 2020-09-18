import 'package:chef_capp_admin_client/index.dart';
import 'package:provider/provider.dart';

class MeasurementUnitsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UnitListController>(
      create: (_) => UnitListController(),
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
                                    child: Text('Measurement Units'),
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              ),
                              Consumer<UnitListController>(
                                builder: (context, controller, _) {
                                  return RaisedButton(
                                    child: Text('ADD NEW UNIT'),
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
                          child: Consumer<UnitListController>(
                            builder: (context, controller, _) {
                              return DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                        'Unit'
                                    ),
                                  ),
                                ],
                                showCheckboxColumn: false,
                                rows: buildUnitRows(context, controller),
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

  List<DataRow> buildUnitRows(BuildContext context, UnitListController parentController) {
    List<DataRow> out = [];
    for (UnitController controller in parentController.units) {
      out.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(controller.singular)),
        ],
        onSelectChanged: (x) {
          parentController.onEdit(context, controller);
        },
      ));
    }
    return out;
  }
}

class MeasurementUnitsAdd extends StatelessWidget {
  final UnitController controller;

  MeasurementUnitsAdd(this.controller);

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
                      'Add Unit',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<UnitController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          key: UniqueKey(),
                          initialValue: controller.singular,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name (Singular)',
                          ),
                          onChanged: (newText) {
                            controller.singularChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: xMargins / 2),
                    child: Consumer<UnitController>(
                      builder: (context, controller, _) {
                        return TextFormField(
                          key: UniqueKey(),
                          initialValue: controller.plural,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Plural',
                          ),
                          onChanged: (newText) {
                            controller.pluralChanged(newText);
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<UnitController>(
                          builder: (context, controller, _) {
                            return RaisedButton(
                              child: Text('Delete Unit'),
                              onPressed: () {
                                controller.onDelete();
                              },
                            );
                          }),
                      SizedBox(
                        width: xMargins,
                      ),
                      Consumer<UnitController>(
                          builder: (context, controller, _) {
                            return RaisedButton(
                              child: Text('Save'),
                              onPressed: () {
                                controller.onSave();
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
}
