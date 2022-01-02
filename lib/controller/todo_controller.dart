import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todoapp/model/todo_model.dart';

class todoController {
  Future<List<Todo>> fetchTodo(bool completed) async {
    List<Todo> TodList = [];
    final response = await http
        .get(Uri.parse('https://secondbasetodo.herokuapp.com/todo/$completed'));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        TodList.add(Todo.fromJson(prod));
      }
      return TodList;
    } else {
      throw Exception('Failed to load todo');
    }
  }
}
