import 'package:flutter/material.dart';
import './views/home.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: TodoHomeView()
    );
  }
}



