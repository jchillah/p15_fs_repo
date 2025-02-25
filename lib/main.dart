import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:p15_fs_repo/firebase_options.dart';
import 'package:p15_fs_repo/src/app.dart';
import 'package:p15_fs_repo/src/data/database_repository.dart';
import 'package:p15_fs_repo/src/data/firebase_auth.dart';
import 'package:p15_fs_repo/src/data/firebase_repository.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize your repositories
  FirestoreDatabase databaseRepository =
      FirestoreDatabase(FirebaseFirestore.instance);
  AuthRepository authRepository = AuthRepository(FirebaseAuth.instance);

  // Run your Flutter application
  runApp(MultiProvider(
    providers: [
      Provider<DatabaseRepository>(
        create: (context) => databaseRepository,
      ),
      Provider<AuthRepository>(
        create: (context) => authRepository,
      ),
    ],
    child: const App(),
  ));
}
