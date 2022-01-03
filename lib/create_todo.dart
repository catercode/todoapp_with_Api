import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/utils.dart';

class CreateTodo extends StatefulWidget {
  CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final _controllerTitle = TextEditingController();

  final _controllerDescription = TextEditingController();

  final _controllerDate = TextEditingController();

  final _controllerTime = TextEditingController();

  final _todocontroller = todoController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor(date: 'appbarColor'),
        title: const Text(
          'Create Todo',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title require';
                  }
                },
                controller: _controllerTitle,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: customColor(date: 'appbarColor')),
                    hintText: 'Please type your event',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: customColor(date: 'appbarColor'),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: customColor(date: 'appbarColor'),
                    ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description require';
                  }
                },
                controller: _controllerDescription,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: customColor(date: 'appbarColor')),
                    hintText: 'Please type your event detail',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: customColor(date: 'appbarColor'),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: customColor(date: 'appbarColor'),
                    ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Date require';
                        }
                      },
                      controller: _controllerDate,
                      maxLines: 1,
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)))
                            .then((selectDate) {
                          final DateFormat _dateFormat =
                              DateFormat('dd/MM/yyyy');
                          _controllerDate.text =
                              _dateFormat.format(selectDate!);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: customColor(date: 'appbarColor')),
                          hintText: 'Event Date',
                          hintStyle: const TextStyle(color: Colors.black),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customColor(date: 'appbarColor'),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: customColor(date: 'appbarColor'),
                          ))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _controllerTime,
                      maxLines: 1,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay?.now())
                            .then((selectTime) {
                          _controllerTime.text = selectTime!.format(context);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Time',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: customColor(date: 'appbarColor')),
                          hintText: 'Event Time',
                          hintStyle: const TextStyle(color: Colors.black),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: customColor(date: 'appbarColor'),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: customColor(date: 'appbarColor'),
                          ))),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                  backgroundColor: customColor(date: 'appbarColor')),
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  var isCompleted = 'false';
                  var myDataTime =
                      _controllerDate.text + "" + _controllerTime.text;
                  bool _successful = await _todocontroller.createTodo(
                      title: _controllerTitle.text,
                      description: _controllerDescription.text,
                      dateTime: myDataTime,
                      completed: isCompleted);
                  if (_successful) {
                    _controllerTitle.clear();
                    _controllerDescription.clear();
                    _controllerTime.clear();
                    _controllerDate.clear();
                    SnackBar snackBar = const SnackBar(
                      content: Text('Todo created!',
                          style: TextStyle(
                            color: Colors.green,
                          )),
                    );
                  
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Failed to create Todo!',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
