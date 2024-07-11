import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/domain/drink.dart';

class DrinkListView extends StatelessWidget {
  final List<Drink> drinks;
  final Function(int) onRemoveDrink;

  const DrinkListView({
    super.key,
    required this.drinks,
    required this.onRemoveDrink,
    required void Function(Drink drink) onEditDrink,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        final drink = drinks[index];
        return ListTile(
          title: Text(drink.type),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(drink.name),
              Text(drink.brand),
              Text('${drink.price.toStringAsFixed(2)}€'),
              Text(drink.vol),
              Text(drink.quantity),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onRemoveDrink(drink.id),
          ),
        );
      },
    );
  }
}
