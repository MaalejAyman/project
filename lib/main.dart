import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginInterface.dart';

void main() => runApp(MyApp());
/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Gestion des Congées';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body:  LoginScreen(),
      ),
    );
  }
}

