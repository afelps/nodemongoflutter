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
  final _completedOpacity = 0.2;

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
    final title = todo['title'];
    final description = todo['description'];
    final createdAt = todo['createdAt'];
    final completedAt = todo['completedAt'];

    return Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(),
        color: Theme.of(context)
            .accentColor
            .withOpacity(this.todo['completed'] ? this._completedOpacity : 0),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () => _navigateToEdit(),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20, height: 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(description),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "created: $createdAt",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Text(
                        "completed: ${this.todo['completed'] ? completedAt : ''}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 10),
                      ))
                ])),
            Checkbox(
              value: this.todo['completed'],
              onChanged: (value) => _setCompleted(value),
            ),
          ],
        ),
      ),
    );
  }
}
