import 'package:flutter/material.dart';
import 'package:selfsync/passwordPage.dart';

class PasswordPageButton extends StatelessWidget {
  const PasswordPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity, // Adjust width as needed
        height: 50, // Adjust height as needed
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordPage()),
            );
          },
          child: Text(
            'Password Manager',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
