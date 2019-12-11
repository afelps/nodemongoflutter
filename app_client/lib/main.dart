import 'package:app_client/screens/home_screen.dart';
import 'package:app_client/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import './views/home.dart';
import 'bloc/bloc.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(primarySwatch: Colors.brown),
      home: BlocProvider(
        builder: (context) => TodoBloc(TodoServiceImpl()),
        // child: TodoHomeView(),
        child: HomeScreen(),
      ),
    );
  }
}
