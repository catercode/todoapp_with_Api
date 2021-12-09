import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../utils.dart';

class Todo_Tile_Widget extends StatefulWidget {
  Todo_Tile_Widget({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
  }) : super(key: key);
  final String title;
  final String description;
  final String dateTime;
  final bool status;

  @override
  State<Todo_Tile_Widget> createState() => _Todo_Tile_WidgetState();
}

class _Todo_Tile_WidgetState extends State<Todo_Tile_Widget> {
  bool ischecked = false;

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
                  onTap: () {
                    setState(() {
                      if (ischecked == false) {
                        ischecked = true;
                      } else {
                        ischecked = false;
                      }
                    });
                  },
                  child: Icon(
                    widget.status
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline,
                    color: customColor(date: widget.dateTime),
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
                        color: customColor(date: widget.dateTime),
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
