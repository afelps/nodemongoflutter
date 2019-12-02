import 'dart:math';

import 'package:app_client/views/detail.dart';
import 'package:app_client/widgets/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoHomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoHomeState();
  }
}

class TodoHomeState extends State<TodoHomeView> {
  var _isLoading = true;
  var todos;

  void _fetchTodos() async {
    final response = await http.get("http://10.0.3.2:3000/api/todo/");

    if (response.statusCode == 200) {
      setState(() {
        this.todos = json.decode(response.body).reversed.toList();
        _isLoading = false;
      });
    }
  }

  _callAddPage() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => TodoDetailView(null)))
        .then((value) {
      _fetchTodos();
    });
  }

  @override
  void initState() {
    super.initState();
    this._fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  this._isLoading = true;
                });
                this._fetchTodos();
              },
            )
          ],
        ),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  key: Key(Random().toString()),
                  padding: EdgeInsets.all(30),
                  itemCount: this.todos.length,
                  itemBuilder: (context, i) {
                    return new TodoHome(this.todos[i]);
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _callAddPage(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
