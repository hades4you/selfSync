import 'package:flutter/material.dart';
import 'package:selfsync/newMemoButton.dart';
import 'package:selfsync/newPasswordButton.dart';
import 'package:selfsync/newScheduleButton.dart';
import 'package:selfsync/passwordPage.dart';
import 'package:selfsync/scheduleDatabase.dart';
import 'package:selfsync/passwordPageButton.dart';
import 'package:selfsync/memoDatabase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('selfSync'),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NewMemoButton(),
                      NewPasswordButton(),
                      NewScheduleButton(),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.35,
                color: Colors.grey[200],
                child: FutureBuilder<List<Event>>(
                  future: ScheduleDatabase.instance.getEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<Event> events = snapshot.data ?? [];
                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            'No upcoming events',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      } else {
                        events.sort((a, b) => DateTime.parse(a.dateTime)
                            .compareTo(DateTime.parse(b.dateTime)));

                        List<Widget> eventWidgets = events
                            .map((event) => ListTile(
                                  title: Text(event.title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(event.dateTime),
                                      Text(
                                        event.context,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteEvent(event.id!);
                                    },
                                  ),
                                ))
                            .toList();
                        return Scrollbar(
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            children: eventWidgets,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: height * 0.35,
                color: Colors.grey[200],
                child: FutureBuilder<List<MemoData>>(
                  future: MemoDatabase.instance.getMemos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<MemoData> memos = snapshot.data ?? [];
                      if (memos.isEmpty) {
                        return Center(
                          child: Text(
                            'No memos',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      } else {
                        List<Widget> memoWidgets = memos
                            .map((memo) => ListTile(
                                  title: Text(memo.title),
                                  onTap: () {
                                    _showMemoContentDialog(context, memo);
                                  },
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteMemo(memo.id!);
                                    },
                                  ),
                                ))
                            .toList();
                        return Scrollbar(
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            children: memoWidgets,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              PasswordPageButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteEvent(int eventId) async {
    await ScheduleDatabase.instance.deleteEvent(eventId);
    setState(() {}); // Refresh UI after deletion
  }

  void _deleteMemo(int memoId) async {
    await MemoDatabase.instance.deleteMemo(memoId);
    setState(() {}); // Refresh UI after deletion
  }

  void _showMemoContentDialog(BuildContext context, MemoData memo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(memo.title),
        content: Text(memo.content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
