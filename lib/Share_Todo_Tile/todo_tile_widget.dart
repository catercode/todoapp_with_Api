import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/model/todo_model.dart';

import '../utils.dart';

class Todo_Tile_Widget extends StatefulWidget {
  Todo_Tile_Widget({
    Key? key,
    required this.completed,
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    // required this.completed
  }) : super(key: key);
  // final Todo todo;
  bool status = false;
  final bool completed;
  final String id;
  final String title;
  final String description;
  final String dateTime;
  // final String completed;

  @override
  State<Todo_Tile_Widget> createState() => _Todo_Tile_WidgetState();
}

class _Todo_Tile_WidgetState extends State<Todo_Tile_Widget> {
  bool ischecked = false;
  final _todocontroller = todoController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      if (widget.completed == false) {
                       // ischecked = true;
                        widget.completed == true;
                        // print(ischecked);
                      } else {
                        //ischecked = false;
                         widget.completed == false;
                        //   print(ischecked);
                        //   _todocontroller.updatetodo(ischecked);
                      }
                    });
                    bool isUpdate = await _todocontroller.updatetodo(
                        completed: ischecked, id: widget.id);
                    if (isUpdate) {
                      // print(widget.id);
                      SnackBar snackBar = const SnackBar(
                        content: Text('Todo updated!',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      SnackBar snackBar = const SnackBar(
                        content: Text('Todo update failed!',
                            style: TextStyle(
                              color: Colors.red,
                            )),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Icon(
                    widget.completed
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline,
                    color: customColor(date: "Today"),
                  ),
                )),
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
                        color: customColor(date: "Today"),
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
                    color: customColor(date: "Today"),
                  ),
                  Text(
                    widget.dateTime,
                    style: TextStyle(
                      color: customColor(date: "Today"),
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
