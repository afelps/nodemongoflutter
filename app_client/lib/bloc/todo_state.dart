import 'package:app_client/models/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodoState {}

class TodoLoadingState extends TodoState {}

class TodoListedState extends TodoState {
  final List<Todo> todos;
  TodoListedState(this.todos);
}

class TodoErrorState extends TodoState {
  final String message;
  TodoErrorState(this.message);
}
