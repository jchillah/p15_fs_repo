import 'package:flutter/material.dart';

class DrinkListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final Function() onClearSearch;
  final bool isSortedAscending;
  final Function() onSortOrderChanged;
  final Function(String) onSortOptionSelected;

  const DrinkListAppBar({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.isSortedAscending,
    required this.onSortOrderChanged,
    required this.onSortOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Drink List'),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          onSelected: onSortOptionSelected,
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'type',
                child: Text('Sort by Type'),
              ),
              const PopupMenuItem(
                value: 'brand',
                child: Text('Sort by Brand'),
              ),
              const PopupMenuItem(
                value: 'price',
                child: Text('Sort by Price'),
              ),
              const PopupMenuItem(
                value: 'quantity',
                child: Text('Sort by Quantity'),
              ),
            ];
          },
        ),
        IconButton(
          icon: Icon(
              isSortedAscending ? Icons.arrow_upward : Icons.arrow_downward),
          onPressed: onSortOrderChanged,
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText:
                  'Search by drink type, name, brand, volume, quantity, or price...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClearSearch,
              ),
            ),
            onChanged: onSearchChanged,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56);
}
