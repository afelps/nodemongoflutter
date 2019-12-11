import 'package:app_client/clients/todo_client.dart';
import 'package:app_client/models/todo.dart';

abstract class TodoService {
  final TodoClient client = TodoClientImpl(); 

  Future<List<Todo>> fetchTodos();
  Future<Todo> addTodo(Todo todo);
  Future<Todo> editTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<Todo> completeTodo(Todo todo);
  Future<Todo> uncompleteTodo(Todo todo);
}

class TodoServiceImpl extends TodoService {
  @override
  Future<Todo> addTodo(Todo todo) async {
    return client.create(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    client.delete(todo);
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    return client.update(todo);
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    return client.list();
  }

  @override
  Future<Todo> completeTodo(Todo todo) async {
    return client.complete(todo);
  }

  @override
  Future<Todo> uncompleteTodo(Todo todo) async {
    return client.uncomplete(todo);
  }



}
