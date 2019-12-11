import 'package:app_client/bloc/bloc.dart';
import 'package:app_client/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),       
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
                  child: Text("Add"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _submitCreateEvent(context),
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

  _submitCreateEvent(BuildContext context) {
    Todo formTodo = Todo(title: _titleController.text, description: _descriptionController.text);
    BlocProvider.of<TodoBloc>(context).add(TodoCreateEvent(formTodo));
    Navigator.pop(context);
  }

}
