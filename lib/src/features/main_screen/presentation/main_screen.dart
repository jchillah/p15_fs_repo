import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/data/firebase_auth.dart';
import 'package:p15_fs_repo/src/features/drink_list/presentation/drink_list_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthRepository>().logout();
              },
              child: const Text('Logout'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const DrinkListScreen();
                  }),
                );
              },
              child: const Icon(Icons.scoreboard),
            ),
          ),
        ],
      ),
    );
  }
}
