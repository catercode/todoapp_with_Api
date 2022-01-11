import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/model/todo_model.dart';

class todoController {
  var client = http.Client();
  Future<List<Todo>> fetchTodo(bool completed) async {
    List<Todo> TodList = [];
    final response = await client
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

// Add new todo to database
  Future<bool> createTodo(
      {required String title,
      required String description,
      required String dateTime,
      required String completed}) async {
    bool isSuccessful = false;
    await http
        .post(
      Uri.parse('https://secondbasetodo.herokuapp.com/todo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'completed': completed,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        isSuccessful = true;
        return Todo.fromJson(jsonDecode(response.body));
      } else {
        isSuccessful = false;
        //throw Exception(Exception);
      }
    }).catchError((onError) {
      isSuccessful = false;
    });
    return isSuccessful;
  }

  //   return TodLi
//update data from database
  Future<bool> updatetodo({required bool completed, required String id}) async {
    bool isSucessfull = false;
    Map<String, bool> body = {"completed": completed};
    Map<String, String> header = {'Content-Type': 'application/json'};
    final response = await http.put(
        Uri.parse('https://secondbasetodo.herokuapp.com/todo/$id'),
        body: jsonEncode(body),
        headers: header);

    if (response.statusCode == 200) {
      isSucessfull = true;
      print(response.body);
      print(isSucessfull);
    } else {
      isSucessfull = false;
    }
    return isSucessfull;
  }

  Future<bool> deleteTodo({required String id}) async {
    Map<String, String> header = {'Content-Type': 'application/json'};
    bool isdeleted = false;
    final response = await http.delete(
        Uri.parse('https://secondbasetodo.herokuapp.com/todo/$id'),
        headers: header);
    if (response.statusCode == 200) {
      isdeleted = true;
    } else {
      isdeleted = false;
    }
    return isdeleted;
  }
}
