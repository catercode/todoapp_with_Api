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
    return Scaffold(
      body: FutureBuilder<List<Todo>>(
        future: _todocontroller.fetchTodo(true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data==null) {
            print('ll');
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 30),
              ),
            );
          }else if(snapshot.hasData){
             return ListView.separated(
                itemBuilder: (context, index) {
                  var compTodo = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (dismissedDirection) async {
                      if (dismissedDirection == DismissDirection.startToEnd) {
                        _todocontroller.deleteTodo(
                            id: snapshot.data![index].id);
                      }
                      SnackBar snackBar = const SnackBar(
                        content: Text('Todo completed delete successful'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        _todocontroller.fetchTodo(true);
                      });
                    },
                    child: Todo_Tile_Widget(
                        completed: true,
                        id: compTodo.id,
                        title: compTodo.title,
                        description: compTodo.description,
                        dateTime: compTodo.dateTime),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: snapshot.data!.length);
          }else{
             return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
        },
      ),
    );
  }
}
