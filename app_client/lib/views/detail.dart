import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoDetailView extends StatefulWidget {
  final todo;
  TodoDetailView(this.todo);
  @override
  State<StatefulWidget> createState() {
    if(this.todo != null)
      return TodoEditState(this.todo);
    else
      return TodoAddState();
  }
}

class TodoEditState extends State<TodoDetailView> {
  final todo;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  TodoEditState(this.todo);

  _delete() async {
    final todoId = todo['_id'];
    final String url = "http://10.0.3.2:3000/api/todo/$todoId";
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      Navigator.pop(context, 'Todo deleted successfuly!');
    }
  }

  _edit() async {
    final jsonbody = {
      "title": titleController.text,
      "description": descriptionController.text
    };
    final todoId = todo['_id'];
    final String url = "http://10.0.3.2:3000/api/todo/$todoId";
    var response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(jsonbody));
    if (response.statusCode == 200) {
      Navigator.pop(context, 'Todo updated successfuly!');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = todo['title'];
    descriptionController.text = todo['description'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _delete(),
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _edit(),
        child: Icon(Icons.edit),
      ),
    );
  }
}

class TodoAddState extends State<TodoDetailView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  TodoAddState();

  _create() async {
    final todo = {
      "title": titleController.text,
      "description": descriptionController.text
    };
    final String url = "http://10.0.3.2:3000/api/todo/";
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(todo));
    if (response.statusCode == 200) {
      Navigator.pop(context, 'Todo created successfuly!');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Todo"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: Icon(Icons.save),
      ),
    );
  }
}
