import 'package:flutter/material.dart';

Color customColor({String? date}) {
  switch (date) {
    case 'Today':
      return Colors.blue;
    case 'Yesterday':
      return Colors.pink;
    case 'Tomorrow':
      return Colors.amber;
    case 'appbarColor':
      return const Color.fromRGBO(37, 43, 103, 1);
    default:
      return Colors.grey;
  }
}
