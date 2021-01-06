import 'package:flutter/material.dart';
import 'package:hello_flutter/databasehelper.dart';
import 'package:hello_flutter/models/task.dart';

class Taskpage extends StatefulWidget {
  final Task task;
  Taskpage({@required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  String _taskTitle = "";

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 6.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png')),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            DatabaseHelper _dbHelper = DatabaseHelper();
                            Task newtask =
                                Task(description: "another task", title: value);
                            if (value != "") {
                              if (widget.task == null) {
                                _dbHelper.insertTask(newtask);
                              } else {
                                print("ayiiiii");
                              }
                            }
                            print("added");
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: InputDecoration(
                              hintText: "Enter your task title",
                              border: InputBorder.none),
                          style: TextStyle(
                              color: Color(0xFF690018),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText:
                            "enter your task description more info about the task ",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                  ),
                ),
                Column(
                  children: [
                    Padding(
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
                                      color: Color(0xff333333), width: 1.5),
                                  borderRadius: BorderRadius.circular(6.0)),
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/check_icon.png'))),
                          Expanded(
                            child: TextField(
                              onSubmitted: (value){
                                
                              },
                              decoration: InputDecoration(
                                  hintText: "enter todos to acomplish the task",
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Taskpage(task: null),
                      ));
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFff2222), Color(0xFFff9999)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0)),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Image(
                    image: AssetImage('assets/images/delete_icon.png'),
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
