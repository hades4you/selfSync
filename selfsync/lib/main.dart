import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('selfSync'),
          actions: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.settings_outlined,
                size: 25,
              ),
            ),
          ],
        ),
        body: Container(
          color: Color(0xFFF5F5F5),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height * 0.06,
                        width: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF5F5F5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.3,
                              blurRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.note_add_outlined,
                          size: 30,
                        ),
                      ),
                      Container(
                        height: height * 0.06,
                        width: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF5F5F5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.3,
                              blurRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.vpn_key_off_outlined,
                          size: 30,
                        ),
                      ),
                      Container(
                        height: height * 0.06,
                        width: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF5F5F5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.3,
                              blurRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.edit_calendar_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
