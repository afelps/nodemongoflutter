import 'package:app_client/models/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodoEvent {}

class TodoListingEvent extends TodoEvent {
  TodoListingEvent();
}

class TodoCreateEvent extends TodoEvent {
  final Todo todo;
  TodoCreateEvent(this.todo);
}

class TodoUpdateEvent extends TodoEvent {
  final Todo todo;
  TodoUpdateEvent(this.todo);
}

class TodoCompleteEvent extends TodoEvent {
  final Todo todo;
  TodoCompleteEvent(this.todo);
}

class TodoUncompleteEvent extends TodoEvent {
  final Todo todo;
  TodoUncompleteEvent(this.todo);
}

class TodoDeleteEvent extends TodoEvent {
  final Todo todo;
  TodoDeleteEvent(this.todo);
}

class TodoErrorEvent extends TodoEvent {
  final String message;
  TodoErrorEvent(this.message);
}
