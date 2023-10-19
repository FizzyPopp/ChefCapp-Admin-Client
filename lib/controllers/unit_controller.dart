import 'package:chef_capp_admin_client/index.dart';

class UnitController extends ChangeNotifier {
  final UnitListController parent;
  String _singular, _plural;
  final int fakeID;

  UnitController(this.fakeID, DBIngredientUnitModel model, this.parent) {
    _singular = model.singular;
    _plural = model.plural;
    //ParentService.database.getIngredients(); // might as well, we're going to need them later

    // testing
    //_recipes = [DummyModels.recipe(), DummyModels.recipe()];
  }

  UnitController.empty(this.parent) : this.fakeID = -1;

  String get singular => _singular;

  String get plural => _plural;

  void singularChanged(String newText) {
    _singular = newText;
  }

  void pluralChanged(String newText) {
    _plural = newText;
  }

  DBIngredientUnitModel toModel() {
    return DBIngredientUnitModel(_singular, _plural, "mass", "whole", 1);
  }

  void onDelete() {
    parent.delete(this);
  }

  void onSave() {
    print("save");
  }
}