import 'package:p15_fs_repo/src/data/database_repository.dart';
import 'package:p15_fs_repo/src/domain/drink.dart';

class MockDatabase implements DatabaseRepository {
  final List<Drink> _drinks = [];

  @override
  Future<List<Drink>> getDrinks() async {
    return Future.value(_drinks);
  }

  @override
  Stream<List<Drink>> drinksStream() {
    throw UnimplementedError();
  }

  @override
  Future<void> addDrink(Drink drink) async {
    if (drink.id != 0) {
      _drinks.add(drink);
    }
  }

  @override
  Future<void> removeDrink(int drinkId) async {
    _drinks.removeWhere((drink) => drink.id == drinkId);
  }

  @override
  Future<void> markDrinkAsDeleted(int drinkId) {
    // TODO: implement markDrinkAsDeleted
    throw UnimplementedError();
  }

  @override
  Future<void> updateDrink(Drink drink) {
    // TODO: implement updateDrink
    throw UnimplementedError();
  }
}
