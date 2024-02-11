import 'package:flutter/material.dart';
import 'package:selfsync/newScheduleScreen.dart';

class NewScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewScheduleScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        backgroundColor: Color(0xFFFFFFFF),
      ),
      child: Icon(
        Icons.edit_calendar_outlined,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}
