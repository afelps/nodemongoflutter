import 'dart:convert';

import 'package:app_client/errors/business_error.dart';
import 'package:http/http.dart' as http;


import 'package:app_client/models/todo.dart';

abstract class TodoClient {
  final String _url = "http://10.0.3.2:3000/api/todo";

  Future<List<Todo>> list();
  Future<Todo> update(Todo todo);
  Future<Todo> complete(Todo todo);
  Future<Todo> uncomplete(Todo todo);
  Future<void> delete(Todo todo);
  Future<Todo> create(Todo todo);
}

class TodoClientImpl extends TodoClient {

  _handleError(http.Response res) {
    throw BusinessError("Error when fetching Todos (${res.statusCode}) : ${res.body}");  
  }
  
  @override
  Future<Todo> complete(Todo todo) async {
    http.Response res = await http.put("$_url/${todo.id}/complete/");
    if(res.statusCode == 200)
      return Todo.fromJson(json.decode(res.body));
    _handleError(res);
    return null;
  }

  @override
  Future<void> delete(Todo todo) async {
    http.Response res = await http.delete("$_url/${todo.id}/");
    if(res.statusCode != 200)
      _handleError(res);
  }

  @override
  Future<List<Todo>> list() async {
    http.Response res = await http.get("$_url/");
    if(res.statusCode == 200)
      return Todo.fromJsonList(json.decode(res.body)).toList();
    _handleError(res);
    return [];
  }

  @override
  Future<Todo> uncomplete(Todo todo) async {
    http.Response res = await http.put("$_url/${todo.id}/uncomplete");
    if(res.statusCode == 200)
      return Todo.fromJson(json.decode(res.body));
    _handleError(res);
    return null;
  }

  @override
  Future<Todo> update(Todo todo) async {
    Map<String, String> updateBody = {
      "title": todo.title,
      "description": todo.description
    };
    http.Response res = await http.put("$_url/${todo.id}/", headers: {"Content-Type" : "application/json"}, body: json.encode(updateBody));
    if(res.statusCode == 200)
      return Todo.fromJson(json.decode(res.body));
    _handleError(res);
    return null;
  }

  @override
  Future<Todo> create(Todo todo) async {
    http.Response res = await http.post("$_url/", headers: {"Content-Type" : "application/json"}, body: json.encode(todo.toJson()));
    if(res.statusCode == 200)
      return Todo.fromJson(json.decode(res.body));
    _handleError(res);
    return null;
  }

}