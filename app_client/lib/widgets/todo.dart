import 'package:app_client/views/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoHome extends StatefulWidget {
  final todo;
  TodoHome(this.todo);
  @override
  State<StatefulWidget> createState() => TodoHomeState(todo);
}

class TodoHomeState extends State<TodoHome> {
  final todo;

  TodoHomeState(this.todo);

  _setCompleted(value) async {
    final todoId = this.todo['_id'];
    final String action = value ? "complete" : "uncomplete";
    final String url = "http://10.0.3.2:3000/api/todo/$todoId/$action";
    final response = await http.put(url);
    if (response.statusCode == 200) {
      setState(() {
        this.todo['completed'] = value;
        this.todo['completedAt'] = json.decode(response.body)['completedAt'];
        print(todo);
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
        elevation: todo['completed'] ? 3 : 10,
        child: _buildListTile(),
      ),
    );
  }

  ListTile _buildListTile() {
    var listTile = ListTile(
      onTap: () => _navigateToEdit(),
      contentPadding: EdgeInsets.all(8.0),
      title: Text(
        todo['title'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 1),
      ),
      subtitle: _buildSubtitle(),
      trailing: Checkbox(
        value: this.todo['completed'],
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
        Text(todo['description']),
        Divider(),
        Text(
          "created: ${todo['createdAt']}",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
        ),
        Text(
          "completed: ${this.todo['completed'] ? todo['completedAt'] : ''}",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
        ),
      ],
    );
  }
}
