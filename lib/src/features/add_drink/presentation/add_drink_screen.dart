import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/data/database_repository.dart';
import 'package:p15_fs_repo/src/domain/drink.dart';
import 'package:p15_fs_repo/src/features/add_drink/presentation/validate_input.dart';
import 'package:p15_fs_repo/src/features/add_drink/utils/snackbar_utils.dart';

class AddDrinkScreen extends StatefulWidget {
  final DatabaseRepository databaseRepository;

  const AddDrinkScreen({Key? key, required this.databaseRepository})
      : super(key: key);

  @override
  AddDrinkScreenState createState() => AddDrinkScreenState();
}

class AddDrinkScreenState extends State<AddDrinkScreen> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _volController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addDrink() async {
    String type = _typeController.text.trim();
    String name = _nameController.text.trim();
    String brand = _brandController.text.trim();
    double price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    String vol = _volController.text.trim();
    String quantity = _quantityController.text.trim();

    if (!validateInputs(type)) {
      showCustomSnackbar(context, 'Please enter the drink type');
      return;
    }

    final drink = Drink(
      id: DateTime.now().millisecondsSinceEpoch,
      quantity: quantity,
      type: type,
      name: name,
      brand: brand,
      price: price,
      vol: vol,
    );

    try {
      await widget.databaseRepository.addDrink(drink);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Failed to add drink: $e');
      showCustomSnackbar(context, 'Failed to add drink. Please try again.');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Drink'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                controller: _typeController, labelText: 'Drink Type'),
            const SizedBox(height: 16.0),
            _buildTextField(
                controller: _nameController, labelText: 'Drink Name'),
            const SizedBox(height: 16.0),
            _buildTextField(
                controller: _brandController, labelText: 'Drink Brand'),
            const SizedBox(height: 16.0),
            _buildTextField(
                controller: _priceController, labelText: 'Drink Price'),
            const SizedBox(height: 16.0),
            _buildTextField(controller: _volController, labelText: 'Drink Vol'),
            const SizedBox(height: 16.0),
            _buildTextField(
                controller: _quantityController, labelText: 'Drink Quantity'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addDrink,
              child: const Text('Add Drink'),
            ),
          ],
        ),
      ),
    );
  }
}
