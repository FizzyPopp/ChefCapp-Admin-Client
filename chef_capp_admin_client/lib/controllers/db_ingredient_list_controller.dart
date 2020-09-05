import 'package:chef_capp_admin_client/index.dart';

class DBIngredientListController extends ChangeNotifier {

  List<DBIngredientModel> _ingredients;

  DBIngredientListController() {
    _ingredients = [];

    // testing
    _ingredients = [DummyModels.dbIngredient(), DummyModels.dbIngredient()];
  }

  List<DBIngredientModel> get ingredients => [..._ingredients];

  void onAddNew(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => IngredientAdd(DBIngredientController.empty(this)),
    );
  }

  void onEdit(BuildContext context, DBIngredientModel m) {
    showDialog(
      context: context,
      builder: (_) => IngredientAdd(DBIngredientController(m, this)),
    );
  }
}