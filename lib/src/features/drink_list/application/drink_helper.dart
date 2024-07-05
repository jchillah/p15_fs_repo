import 'package:p15_fs_repo/src/domain/drink.dart';

class DrinkHelper {
  static List<Drink> filterAndSortDrinks({
    required List<Drink> drinks,
    required String query,
    required bool isSortedAscending,
    required String sortOption,
  }) {
    final queryLowerCase = query.toLowerCase();
    final filteredDrinks = drinks
        .where((drink) =>
            drink.type.toLowerCase().contains(queryLowerCase) ||
            drink.name.toLowerCase().contains(queryLowerCase) ||
            drink.vol.toLowerCase().contains(queryLowerCase) ||
            drink.quantity.toLowerCase().contains(queryLowerCase) ||
            drink.brand.toLowerCase().contains(queryLowerCase) ||
            drink.price.toString().contains(queryLowerCase))
        .toList();

    filteredDrinks.sort((a, b) {
      int comparison;
      switch (sortOption) {
        case 'type':
          comparison = a.type.compareTo(b.type);
          break;
        case 'brand':
          comparison = a.brand.compareTo(b.brand);
          break;
        case 'price':
          comparison = a.price.compareTo(b.price);
          break;
        case 'quantity':
          comparison = a.quantity.compareTo(b.quantity);
          break;
        case 'name':
        default:
          comparison = a.name.compareTo(b.name);
          break;
      }
      return isSortedAscending ? comparison : -comparison;
    });

    return filteredDrinks;
  }
}
