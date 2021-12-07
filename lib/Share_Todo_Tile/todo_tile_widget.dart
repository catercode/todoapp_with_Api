import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import '../utils.dart';

class Todo_Tile_Widget extends StatelessWidget {
  Todo_Tile_Widget(
      {Key? key,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.status})
      : super(key: key);
  final String title;
  final String description;
  final String dateTime;
  final bool status;
  bool iscomplete = false;

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
                    // setState(() {
                    //   if (iscomplete == false) {
                    //     iscomplete = true;
                    //     print(iscomplete);
                    //   } else {
                    //     iscomplete = false;
                    //     print(iscomplete);
                    //   }
                    // });
                  },
                  child: Icon(
                    status
                        ? Icons.check_circle_outline
                        : Icons.check_circle_rounded,
                    color: customColor(date: dateTime),
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
                    title,
                    style: TextStyle(
                        color: customColor(date: 'appbarColor'),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    description,
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
                    color: customColor(date: dateTime),
                  ),
                  Text(
                    dateTime,
                    style: TextStyle(
                      color: customColor(date: dateTime),
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
