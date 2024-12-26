import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:library_univercity/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Admin() ,
    );
  }
}
