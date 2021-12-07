import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoapp/Share_Todo_Tile/todo_tile_widget.dart';
import 'package:todoapp/create_todo.dart';

import 'package:todoapp/utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  String loadtodo = 'Todo';
  final List<Map<String, dynamic>> _completed = [];
  final List<Map<String, dynamic>> _uncompleted = [];
  final List<Map<String, dynamic>> _data = [
    {
      'title': 'Trip to Space',
      'description': 'This trip will last a week',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Trip to USA',
      'description': 'I will spend it with me family',
      'date_time': 'Today',
      'status': true,
    },
    {
      'title': 'Order for Car',
      'description': 'I want to buy a car this month',
      'date_time': '20/12/2021',
      'status': false,
    }
  ];

  void initState() {
    for (Map<String, dynamic> element in _data) {
      if (element['status']) {
        _completed.add(element);
        print(element);
      } else {
        _uncompleted.add(element);
        print(element);
      }
    }
    try {
      Timer(const Duration(seconds: 10), () {
        callback();
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  int count = 0;
  bool iscomplete = false;
  void callback() {
    setState(() {
      count = count = 1;
    });
  }

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
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10,
            child: Text(
              ' ${_completed.length}',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                setState(() {
                  if (loadtodo == 'Todo') {
                    loadtodo = value;
                    print(value);
                  } else {
                    loadtodo = value;
                    print(value);
                  }
                });
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text('Todo'),
                    value: 'Todo',
                  ),
                  PopupMenuItem(
                    child: Text('Complete'),
                    value: 'Complete',
                  )
                ];
              }),
          const SizedBox(
            width: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return count == 0
                ? SkeletonAnimation(
                    shimmerColor: customColor(date: 'appbarColor'),
                    borderRadius: BorderRadius.circular(20),
                    shimmerDuration: 1000,
                    child: Todo_Tile_Widget(
                        title: '',
                        description: '',
                        dateTime: '',
                        status: false),
                  )
                : Todo_Tile_Widget(
                    title: loadtodo == 'Todo'
                        ? _completed[index]['title']
                        : _uncompleted[index]['title'],
                    description: loadtodo == 'Todo'
                        ? _completed[index]['description']
                        : _uncompleted[index]['description'],
                    dateTime: loadtodo == 'Todo'
                        ? _completed[index]['date_time']
                        : _uncompleted[index]['date_time'],
                    status: loadtodo == 'Todo'
                        ? _completed[index]['status']
                        : _uncompleted[index]['status']);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount:
              loadtodo == 'Todo' ? _completed.length : _uncompleted.length),
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
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return Todo_Tile_Widget(
                            title: _uncompleted[index]['title'],
                            description: _uncompleted[index]['description'],
                            dateTime: _uncompleted[index]['date_time'],
                            status: _uncompleted[index]['status']);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: _uncompleted.length);
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
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Complete',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      ' ${_uncompleted.length}',
                      style: const TextStyle(
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
