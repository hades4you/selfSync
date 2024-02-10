import 'package:flutter/material.dart';
import 'package:selfsync/newMemoScreen.dart';

class NewMemoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the new memo screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewMemoScreen()),
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
        Icons.note_add_outlined,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}
