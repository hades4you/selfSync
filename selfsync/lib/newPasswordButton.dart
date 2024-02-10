import 'package:flutter/material.dart';
import 'package:selfsync/newPasswordScreen.dart';
import 'package:selfsync/passwordPage.dart';

class NewPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the new password screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPasswordScreen()),
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
        Icons.vpn_key_off_outlined,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}
