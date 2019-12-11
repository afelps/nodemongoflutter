import 'package:app_client/bloc/bloc.dart';
import 'package:app_client/bloc/todo_event.dart';
import 'package:app_client/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  final Todo todo;
  EditScreen(this.todo);

  @override
  _EditScreenState createState() => _EditScreenState(todo);
}

class _EditScreenState extends State<EditScreen> {
  Todo todo;
  
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _EditScreenState(this.todo) {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _submitDeleteEvent(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      size: 100,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    TextFormField(                      
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Title",
                        hintText: "What needs to be done?",
                      ),
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Description",
                            hintText: "Put some more details in here")),
                  ],
                ),
                RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Edit"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _submitUpdateEvent(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() { 
    _titleController.dispose();
    _descriptionController.dispose();    
    super.dispose();
  }

  _submitUpdateEvent(BuildContext context) {
    Todo formTodo = Todo(id: this.todo.id, title: _titleController.text, description: _descriptionController.text);
    BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(formTodo));
    Navigator.pop(context);
  }

    _submitDeleteEvent(BuildContext context) {    
    BlocProvider.of<TodoBloc>(context).add(TodoDeleteEvent(this.todo));
    Navigator.pop(context);
  }


}
