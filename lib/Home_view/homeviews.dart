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
  List<Map<String, dynamic>> _completed = [];
  List<Map<String, dynamic>> uncompleted = [];
  List<Map<String, dynamic>> data = [
    {
      'title': 'Trip to Space',
      'description':
          'This trip will last a week, and I intend going with you guys',
      'dateTime': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Trip to Dubai',
      'description':
          'This trip will last a month, and I intend going with you guys and my mom ',
      'dateTime': 'Today',
      'status': false,
    },
    {
      'title': 'Buy a Car',
      'description':
          'After trip I intend to buy 2022 latest Model S car in tesla company',
      'dateTime': '01/01/2022',
      'status': false,
    },
    {
      'title': 'Lunch Kenkey',
      'description':
          'I want to take kenkey as lunch to day at 12:30 PM in ivalley Ghana',
      'dateTime': 'Today',
      'status': true,
    },
  ];
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (element['status']) {
        _completed.add(element);
      } else {
        uncompleted.add(element);
      }
    }
    Timer(const Duration(seconds: 10), () => callback());

    super.initState();
  }

  String isloaded = 'Todo';
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
            radius: 10,
            backgroundColor: Colors.amber,
            child: Text('${uncompleted.length}'),
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
                        status: false))
                : Todo_Tile_Widget(
                    title: isloaded == 'Todo'
                        ? uncompleted[index]['title']
                        : _completed[index]['title'],
                    description: isloaded == 'Todo'
                        ? uncompleted[index]['description']
                        : _completed[index]['description'],
                    dateTime: isloaded == 'Todo'
                        ? uncompleted[index]['dateTime']
                        : _completed[index]['dateTime'],
                    status: isloaded == 'Todo'
                        ? uncompleted[index]['status']
                        : _completed[index]['status'],
                  );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: uncompleted.length),
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
                          title: _completed[index]['title'],
                          description: _completed[index]['description'],
                          dateTime: _completed[index]['dateTime'],
                          status: _completed[index]['status'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: _completed.length);
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
                      ' ${_completed.length}',
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
