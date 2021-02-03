import 'package:flutter/material.dart';
import 'package:hello_flutter/databasehelper.dart';
import 'package:hello_flutter/models/task.dart';
import 'package:hello_flutter/models/todo.dart';
import 'package:hello_flutter/widgets.dart';

class Taskpage extends StatefulWidget {
  final Task task;
  Taskpage({@required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  String _taskTitle = "";
  String description = "";
  int taskId = 0;
  FocusNode titleFocus;
  FocusNode descriptionfocus;
  FocusNode todofocus;
  bool contentVisibile = false;

  @override
  void initState() {
    if (widget.task != null) {
      contentVisibile = true;
      _taskTitle = widget.task.title;
      description = widget.task.description;
      taskId = widget.task.id;
    }
    titleFocus = FocusNode();
    descriptionfocus = FocusNode();
    todofocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    descriptionfocus.dispose();
    todofocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF111111),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 32.0, bottom: 6.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png')),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: titleFocus,
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (widget.task == null) {
                                Task newtask = Task(
                                    description: "Task Description",
                                    title: value);
                                taskId = await _dbHelper.insertTask(newtask);
                                setState(() {
                                  contentVisibile = true;
                                  _taskTitle = value;
                                });
                                print("new task $taskId");
                              } else {
                                _dbHelper.updateTaskTitle(taskId, value);
                                print("task updated");
                              }
                            }
                            descriptionfocus.requestFocus();
                            print("added");
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: InputDecoration(
                              hintText: "Enter your task title",
                              hintStyle: TextStyle(color: Color(0xff999999)),
                              border: InputBorder.none),
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF06a10b)),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: contentVisibile,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: TextField(
                        focusNode: descriptionfocus,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (taskId != 0) {
                              await _dbHelper.updateTaskDescription(
                                  taskId, value);
                              description = value;
                            }
                          }
                          todofocus.requestFocus();
                        },
                        controller: TextEditingController()..text = description,
                        decoration: InputDecoration(
                            hintText:
                                "enter your task description more info about the task ",
                            hintStyle: TextStyle(color: Color(0xff999999)),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0)),
                        style: TextStyle(color: Color(0xFfffffff))),
                  ),
                ),
                Visibility(
                  visible: contentVisibile,
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(taskId),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (snapshot.data[index].isDone == 0) {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 1);
                                  } else {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 0);
                                  }
                                  setState(() {});
                                },
                                child: TodoWidget(
                                  text: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: contentVisibile,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(right: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Color(0xfff3f3f3), width: 1.5),
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/check_icon.png'))),
                        Expanded(
                          child: TextField(
                              focusNode: todofocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                if (value != "") {
                                  if (taskId != 0) {
                                    DatabaseHelper _dbHelper = DatabaseHelper();
                                    Todo newtodo = Todo(
                                        isDone: 0,
                                        title: value,
                                        taskId: taskId);
                                    await _dbHelper.insertTodo(newtodo);
                                    setState(() {});
                                    print("todo $value");
                                  }
                                } else {
                                  print("task dosent exist");
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "list your todos",
                                  hintStyle:
                                      TextStyle(color: Color(0xff999999)),
                                  border: InputBorder.none),
                              style: TextStyle(color: Color(0xFfffffff))),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: contentVisibile,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if (taskId != 0) {
                      await _dbHelper.deleteTask(taskId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFff9000), Color(0xFFff0000)],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image(
                      image: AssetImage('assets/images/delete_icon.png'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
