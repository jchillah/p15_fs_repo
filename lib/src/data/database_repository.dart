import 'package:p15_fs_repo/src/domain/drink.dart';

abstract class DatabaseRepository {
  Future<List<Drink>> getDrinks();
  Stream<List<Drink>> drinksStream();
  Future<void> addDrink(Drink drink);
  Future<void> removeDrink(int drinkId);
}
