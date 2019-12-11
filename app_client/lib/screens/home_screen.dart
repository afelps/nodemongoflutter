import 'package:app_client/bloc/bloc.dart';
import 'package:app_client/models/todo.dart';
import 'package:app_client/widgets/todo_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Home"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _submitEvent(context, TodoListingEvent()),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoErrorState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoadingState) {
                _submitEvent(context, TodoListingEvent());
                return _buildLoading();
              } else if (state is TodoListedState)
                return _buildTodoList(state.todos);
              else
                return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddScreen(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _submitEvent(BuildContext context, TodoEvent event) {
    BlocProvider.of<TodoBloc>(context).add(event);
  }

  _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
  _buildTodoList(List<Todo> todos) => Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, i) {
            return TodoCard(todos[i]);
          },
        ),
      );

  _navigateToAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<TodoBloc>(context), child: AddScreen()),
      ),
    );
  }


}
