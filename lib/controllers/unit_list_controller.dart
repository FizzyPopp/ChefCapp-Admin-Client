import 'package:chef_capp_admin_client/index.dart';

class UnitListController extends ChangeNotifier {
  List<UnitController> _units = [];
  Function genFakeID = fakeIDClosure();

  static Function fakeIDClosure() {
    int fakeID = 0;
    return () {
      return fakeID++;
    };
  }

  UnitListController() {
    setUnits();
  }

  void setUnits() async {
    _units = (await ParentService.database.getSpecificUnits()).map<UnitController>((m) => UnitController(genFakeID(), m, this)).toList();
    notifyListeners();
  }

  List<UnitController> get units => [..._units];

  void onAddNew(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => MeasurementUnitsAdd(UnitController.empty(this)),
    );
  }

  void onEdit(BuildContext context, UnitController controller) {
    showDialog(
      context: context,
      builder: (_) => MeasurementUnitsAdd(controller),
    );
  }

  void delete(UnitController controller) {
    print("delete unit");
  }
}