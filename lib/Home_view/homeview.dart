import 'dart:async';

import 'package:flutter/material.dart';

import 'package:todoapp/utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  int count = 0;
  void callback() {
    setState(() {
      count = count + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      Timer(const Duration(seconds: 10), () {
        callback();
      });
    } catch (e) {
      print(e);
    }
  }

  // var mywait = SkeletonAnimation(),
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
        actions: const [
          Icon(Icons.menu),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, int index) {
          return count == 0
              ? SkeletonAnimation(
                  shimmerColor: const Color.fromRGBO(37, 43, 103, .2),
                  borderRadius: BorderRadius.circular(20),
                  shimmerDuration: 1000,
                  child: TodoCardWidget(
                    title: count == 0 ? '' : 'Trip to Space',
                    description: count == 0
                        ? ''
                        : 'The trip will last a week,The trip will last a week',
                    dateTime: count == 0 ? '' : 'Today',
                    myStatus: count == 0 ? false : true,
                  ),
                )
              : TodoCardWidget(
                  title: count == 0 ? '' : 'Trip to Space',
                  description: count == 0
                      ? ''
                      : 'The trip will last a week,The trip will last a week,The trip will last a week',
                  dateTime: count == 0 ? '' : 'Yesterday',
                  myStatus: count == 0 ? false : true,
                );
        },
        separatorBuilder: (context, int undex) {
          return const SizedBox(
            height: 0,
          );
        },
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: callback,
        child: const Icon(Icons.add),
        backgroundColor: customColor(date: 'appbarColor'),
      ),
      bottomNavigationBar: SafeArea(
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
                    '$count',
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
    );
  }
}

class TodoCardWidget extends StatefulWidget {
  const TodoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.myStatus,
  }) : super(key: key);
  final String title;
  final String description;
  final String dateTime;
  final bool myStatus;

  @override
  State<TodoCardWidget> createState() => _TodoCardWidgetState();
}

class _TodoCardWidgetState extends State<TodoCardWidget> {
  bool x = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (x == false) {
                      x = true;

                      print(x);
                    } else {
                      x = false;
                      print(x);
                    }
                  });
                },
                child: Icon(
                  x ? Icons.check_circle_outline : Icons.check_circle_rounded,
                  color: customColor(date: widget.dateTime),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: customColor(date: 'appbarColor'),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 16.0,
                    color: customColor(date: widget.dateTime),
                  ),
                  Text(
                    widget.dateTime,
                    style: TextStyle(
                      color: customColor(date: widget.dateTime),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
