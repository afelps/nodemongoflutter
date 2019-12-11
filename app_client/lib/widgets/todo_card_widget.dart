import 'package:app_client/bloc/bloc.dart';
import 'package:app_client/models/todo.dart';
import 'package:app_client/screens/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');
  TodoCard(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onLongPress: () => _navigateToEditScreen(context),
        child: Card(
          elevation: todo.completed ? 3 : 10,
          child: _buildListTile(context),
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context) => ListTile(
        onTap: () => {},
        contentPadding: EdgeInsets.all(8.0),
        title: Text(
          todo.title,
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 1),
        ),
        subtitle: _buildSubtitle(),
        trailing: Checkbox(
          value: todo.completed,
          onChanged: (completed) =>
              _toggleCompleted(context, completed), //setCompleted
        ),
      );

  Column _buildSubtitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Text(todo.description),
          Divider(),
          Text(
            "created: ${dateFormat.format(todo.createdAt)}",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
          ),
          Text(
            "completed: ${this.todo.completed ? dateFormat.format(todo.completedAt) : ''}",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
          ),
        ],
      );

  _toggleCompleted(context, complete) {
    TodoEvent event = complete
        ? TodoCompleteEvent(this.todo)
        : TodoUncompleteEvent(this.todo);
    BlocProvider.of<TodoBloc>(context).add(event);
  }

  _navigateToEditScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<TodoBloc>(context), child: EditScreen(this.todo)),
      ),
    );
  }
}
