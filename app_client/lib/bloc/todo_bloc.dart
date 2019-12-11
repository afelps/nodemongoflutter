import 'dart:async';
import 'package:app_client/errors/business_error.dart';
import 'package:app_client/models/todo.dart';
import 'package:app_client/services/todo_service.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService todoService;
  Map<String, Todo> cachedTodoMap;
  
  TodoBloc(this.todoService);


  @override
  TodoState get initialState => TodoLoadingState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    try {
      if (event is TodoListingEvent) {
        yield TodoLoadingState();
        List<Todo> todoList = await todoService.fetchTodos();        
        cachedTodoMap = Map.fromEntries(todoList.toList().map((todo) => MapEntry(todo.id, todo)));
        yield TodoListedState(cachedTodoMap.values.toList());
      }
      else if (event is TodoCompleteEvent) {
        Todo updatedTodo = await todoService.completeTodo(event.todo);
        cachedTodoMap[updatedTodo.id] = updatedTodo;
        yield TodoListedState(cachedTodoMap.values.toList());
      }
      else if (event is TodoUncompleteEvent) {
        Todo updatedTodo = await todoService.uncompleteTodo(event.todo);
        cachedTodoMap[updatedTodo.id] = updatedTodo;
        yield TodoListedState(cachedTodoMap.values.toList());
      }
      else if (event is TodoCreateEvent) {
        await todoService.addTodo(event.todo);
        yield TodoLoadingState();
      }
      else if (event is TodoUpdateEvent) {
        Todo updatedTodo = await todoService.editTodo(event.todo);
        cachedTodoMap[updatedTodo.id] = updatedTodo;
        yield TodoListedState(cachedTodoMap.values.toList());
      } else if (event is TodoDeleteEvent) {
        await todoService.deleteTodo(event.todo);
        cachedTodoMap.remove(event.todo.id);
        yield TodoListedState(cachedTodoMap.values.toList());
      } else if (event is TodoErrorEvent) {
        yield TodoErrorState("Error: ${event.message}");       
      } else {
        yield TodoErrorState("Not recognizable event $event");
      }
    } on BusinessError catch (e) {
      yield TodoErrorState("Unhandled Error: ${e.message}");      
    }
  }
}
