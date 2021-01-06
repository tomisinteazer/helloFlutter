import 'package:flutter/material.dart';

class TaskbarCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskbarCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "New Task",
              style: TextStyle(
                  color: Color(0xFF690018),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                desc ??
                    "add your tasks descriptiion here and we move, Yunno everythin you wanna sort out",
                style: TextStyle(
                    color: Color(0xFF333333),
                    height: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ));
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  TodoWidget({this.text, @required this.isDone});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
              width: 20.0,
              height: 20.0,
              margin: EdgeInsets.only(right: 16.0),
              decoration: BoxDecoration(
                  color: isDone ? Color(0xFF690018) : Colors.transparent,
                  border: isDone
                      ? null
                      : Border.all(color: Color(0xff333333), width: 1.5),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Image(image: AssetImage('assets/images/check_icon.png'))),
          Text(
            text ?? "unamed task",
            style: TextStyle(
                color: isDone ? Color(0xff610018) : Color(0xff999999),
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
                fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
