import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_class/home.dart';
import 'package:firestore_class/signup.dart';
import 'package:firestore_class/storage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signup(),
    );
  }
}
