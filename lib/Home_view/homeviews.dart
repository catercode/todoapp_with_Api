import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoapp/Share_Todo_Tile/complete_share_widget.dart';
import 'package:todoapp/Share_Todo_Tile/todo_tile_widget.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/create_todo.dart';
import 'package:todoapp/model/todo_model.dart';

import 'package:todoapp/utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final _todoController = todoController();
  late Future<List<Todo>> futureTodo;
  var _todo;

  @override
  int value = 1;
  String isloaded = 'Todo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor(date: 'appbarColor'),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_img.jpg'),
            backgroundColor: Colors.amber,
          ),
        ),
        title: const Text(
          'My Task',
        ),
        actions: [
          const CircleAvatar(
            radius: 10,
            backgroundColor: Colors.amber,
            child: Text('2'),
          ),
          const SizedBox(
            width: 20,
          ),
          PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  if (isloaded == 'Todo') {
                    isloaded = value;
                  } else {
                    isloaded = value;
                  }
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Todo'),
                    value: 'Todo',
                  ),
                  const PopupMenuItem(
                    child: Text('Completed'),
                    value: 'Completed',
                  )
                ];
              },
              child: const Icon(Icons.menu)),
          const SizedBox(
            width: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoController.fetchTodo(false),
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
          return ListView.builder(
            itemBuilder: (context, index) {
              _todo = snapshot.data![index];

              return Todo_Tile_Widget(
                  title: _todo.title,
                  description: _todo.description,
                  dateTime: _todo.dateTime);
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateTodo();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: customColor(date: 'appbarColor'),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return const completeTodoWidget();
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: customColor(
                  date: 'appbarColor',
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Complete',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '2',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
