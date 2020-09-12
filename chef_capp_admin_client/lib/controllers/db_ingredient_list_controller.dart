import 'package:chef_capp_admin_client/index.dart';

class DBIngredientListController extends ChangeNotifier {

  List<DBIngredientModel> _ingredients;
  bool _haveIngredients;

  DBIngredientListController() {
    _haveIngredients = false;
    _ingredients = [];
    //fillIngredients();

    // testing
    _ingredients = [DummyModels.dbIngredient(), DummyModels.dbIngredient()];
    _haveIngredients = true;
  }

  List<DBIngredientModel> get ingredients => [..._ingredients];

  Future<void> fillIngredients() async {
    _ingredients = await ParentService.database.getIngredients();
    _haveIngredients = true;
    notifyListeners();
  }

  void onAddNew(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => IngredientAdd(DBIngredientController.empty(this)),
    );
  }

  void onEdit(BuildContext context, DBIngredientModel m) {
    if (!_haveIngredients) {
      return;
    }
    showDialog(
      context: context,
      builder: (_) => IngredientAdd(DBIngredientController(m, this)),
    );
  }
}