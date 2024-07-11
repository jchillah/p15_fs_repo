import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p15_fs_repo/src/data/firebase_auth.dart';
import 'package:p15_fs_repo/src/features/authentication/presentation/login_screen.dart';
import 'package:p15_fs_repo/src/features/main_screen/presentation/main_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const loginKey = ValueKey('loginScreen');
    const mainKey = ValueKey('MainScreen');

    return StreamBuilder(
        stream: context.read<AuthRepository>().authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          final user = snapshot.data;
          return MaterialApp(
            key: user == null ? loginKey : mainKey,
            home: user == null ? LoginScreen() : MainScreen(),
          );
        });
  }
}
