import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Share_Todo_Tile/todo_tile_widget.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/model/todo_model.dart';

class completeTodoWidget extends StatefulWidget {
  const completeTodoWidget({
    Key? key,
   
  }) : super(key: key);
  // final Todo todo;
  
  @override
  State<completeTodoWidget> createState() => _completeTodoWidgetState();
}

class _completeTodoWidgetState extends State<completeTodoWidget> {
  final _todocontroller = todoController();
  late Future<List<Todo>> fetchComplete;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: _todocontroller.fetchTodo(true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return const Text(
            'Something went wrong',
            style: TextStyle(fontSize: 30),
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              var compTodo = snapshot.data![index];
              return Todo_Tile_Widget(
                  title: compTodo.title,
                  description: compTodo.description,
                  dateTime: compTodo.dateTime);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: snapshot.data!.length);
      },
    );
  }
}
