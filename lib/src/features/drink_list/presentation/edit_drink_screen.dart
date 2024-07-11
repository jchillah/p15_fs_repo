import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/data/database_repository.dart';
import 'package:p15_fs_repo/src/domain/drink.dart';
import 'package:p15_fs_repo/src/features/add_drink/presentation/validate_input.dart';
import 'package:p15_fs_repo/src/features/add_drink/utils/snackbar_utils.dart';
import 'package:provider/provider.dart';

class EditDrinkScreen extends StatefulWidget {
  final Drink drink;

  const EditDrinkScreen({
    super.key,
    required this.drink,
  });

  @override
  _EditDrinkScreenState createState() => _EditDrinkScreenState();
}

class _EditDrinkScreenState extends State<EditDrinkScreen> {
  late TextEditingController _typeController;
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _priceController;
  late TextEditingController _volController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.drink.type);
    _nameController = TextEditingController(text: widget.drink.name);
    _brandController = TextEditingController(text: widget.drink.brand);
    _priceController =
        TextEditingController(text: widget.drink.price.toString());
    _volController = TextEditingController(text: widget.drink.vol);
    _quantityController = TextEditingController(text: widget.drink.quantity);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _volController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _updateDrink() async {
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

    final updatedDrink = Drink(
      id: widget.drink.id,
      type: type,
      name: name,
      brand: brand,
      price: price,
      vol: vol,
      quantity: quantity,
      uid: '', // Assuming uid is required in Drink constructor
    );

    try {
      await context.read<DatabaseRepository>().updateDrink(updatedDrink);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Failed to update drink: $e');
      showCustomSnackbar(context, 'Failed to update drink. Please try again.');
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
        title: const Text('Edit Drink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              _buildTextField(
                  controller: _volController, labelText: 'Drink Vol'),
              const SizedBox(height: 16.0),
              _buildTextField(
                  controller: _quantityController, labelText: 'Drink Quantity'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateDrink,
                child: const Text('Update Drink'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
