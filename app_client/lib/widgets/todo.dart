import 'package:app_client/models/todo.dart';
import 'package:app_client/views/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TodoHome extends StatefulWidget {
  final todo;
  TodoHome(this.todo);
  @override
  State<StatefulWidget> createState() => TodoHomeState(todo);
}

class TodoHomeState extends State<TodoHome> {
  Todo todo;
  DateFormat dateFormat;
  TodoHomeState(this.todo);

  @override
  void initState() { 
    super.initState();
    dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');
  }

  _setCompleted(bool value) async {    
    final String action = value ? "complete" : "uncomplete";
    final String url = "http://10.0.3.2:3000/api/todo/${todo.id}/$action";
    final response = await http.put(url);
    if (response.statusCode == 200) {
      Todo responseTodo = Todo.fromJson(json.decode(response.body));
      setState(() {
        this.todo = responseTodo;
      });
    }
  }

  _navigateToEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoDetailView(this.todo),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: todo.completed ? 3 : 10,
        child: _buildListTile(),
      ),
    );
  }

  ListTile _buildListTile() {
    var listTile = ListTile(
      onTap: () => _navigateToEdit(),
      contentPadding: EdgeInsets.all(8.0),
      title: Text(
        todo.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 1),
      ),
      subtitle: _buildSubtitle(),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) => _setCompleted(value),
      ),
    );
    return listTile;
  }

  Column _buildSubtitle() {
    return Column(
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
  }
}
