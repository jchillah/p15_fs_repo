import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/data/database_repository.dart';
import 'package:p15_fs_repo/src/data/firebase_auth.dart';
import 'package:p15_fs_repo/src/domain/drink.dart';
import 'package:p15_fs_repo/src/features/add_drink/presentation/add_drink_screen.dart';
import 'package:p15_fs_repo/src/features/drink_list/application/drink_helper.dart';

import 'drink_list_appbar.dart';
import 'drink_list_view.dart';

class DrinkListScreen extends StatefulWidget {
  final DatabaseRepository databaseRepository;

  const DrinkListScreen({
    super.key,
    required this.databaseRepository,
    required AuthRepository authRepository,
  });

  @override
  DrinkListScreenState createState() => DrinkListScreenState();
}

class DrinkListScreenState extends State<DrinkListScreen> {
  late Stream<List<Drink>> _drinksStream;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _isSortedAscending = true;
  String _sortOption = 'name'; // Default sort option

  @override
  void initState() {
    super.initState();
    _drinksStream = widget.databaseRepository.drinksStream();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrinkListAppBar(
        searchController: _searchController,
        onSearchChanged: (value) {
          setState(() {
            _query = value;
          });
        },
        onClearSearch: () {
          _searchController.clear();
          setState(() {
            _query = '';
          });
        },
        isSortedAscending: _isSortedAscending,
        onSortOrderChanged: () {
          setState(() {
            _isSortedAscending = !_isSortedAscending;
          });
        },
        onSortOptionSelected: (value) {
          setState(() {
            _sortOption = value;
          });
        },
      ),
      body: StreamBuilder<List<Drink>>(
        stream: _drinksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drinks available'));
          }

          final drinks = snapshot.data!;
          final filteredDrinks = DrinkHelper.filterAndSortDrinks(
            drinks: drinks,
            query: _query,
            isSortedAscending: _isSortedAscending,
            sortOption: _sortOption,
          );

          return DrinkListView(
            drinks: filteredDrinks,
            onRemoveDrink: _removeDrink,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDrinkScreen(
                databaseRepository: widget.databaseRepository,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _removeDrink(int drinkId) async {
    try {
      await widget.databaseRepository.removeDrink(drinkId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Drink removed successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint('Failed to remove drink: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to remove drink. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
