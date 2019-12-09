import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todo extends Equatable {
  String id;
  String title;
  String description;
  bool completed;
  DateTime completedAt;
  DateTime createdAt;

  Todo(
      {this.id,
      @required this.title,
      @required this.description,
      this.completed,
      this.completedAt,
      this.createdAt});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['_id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        completed: json['completed'] as bool ?? false,
        completedAt: json['completedAt'] == null
            ? null
            : DateTime.parse(json['completedAt'] as String),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String));
  }

  static List<Todo> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => Todo.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': this.id,
        'title': this.title,
        'description': this.description,
        'completed': this.completed,
        'completedAt': this.completedAt?.toIso8601String(),
        'createdAt': this.createdAt?.toIso8601String()
      };

  @override
  List<Object> get props => [id];
}
