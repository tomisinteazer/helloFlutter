import 'package:flutter/material.dart';
import 'package:hello_flutter/databasehelper.dart';
import 'package:hello_flutter/screens/taskpage.dart';
import 'package:hello_flutter/widgets.dart';

class Homepage extends StatefulWidget {
 
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      color: Color(0xFFf6f6f6),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 32.0,
                bottom: 32.0,
              ),
              child: Image(image: AssetImage('assets/images/logo.png')),
            ),
            Expanded(
                child: FutureBuilder(
              initialData: [],
              future: _dbHelper.getTasks(),
              builder: (context, snapshot) {
                return ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Taskpage(task:snapshot.data[index]),
                                )).then((value) {
                              setState(() {});
                            });
                          },
                          child: TaskbarCardWidget(
                            title: snapshot.data[index].title,
                          ),
                        );
                      }),
                );
              },
            )),
          ],
        ),
        Positioned(
          bottom: 24.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Taskpage(task: null,),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                  color: Color(0xFF690018),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Image(
                image: AssetImage('assets/images/add_icon.png'),
              ),
            ),
          ),
        )
      ]),
    )));
  }
}
