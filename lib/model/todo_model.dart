import 'dart:convert';

List<Todo> albumFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String albumToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.completed,
  });

  String id;
  String title;
  String description;
  String dateTime;
  bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        dateTime: json["dateTime"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "completed": completed,
      };
}
