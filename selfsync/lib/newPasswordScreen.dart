import 'package:flutter/material.dart';
import 'package:selfsync/passwordDatabase.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController mailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    mailIdController.dispose();
    passwordController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: accountController,
              decoration: InputDecoration(labelText: 'Account'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: mailIdController,
              decoration: InputDecoration(labelText: 'Mail ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'URL'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                // Handle form submission
                String account = accountController.text;
                String mailId = mailIdController.text;
                String password = passwordController.text;
                String url = urlController.text;

                // Create a PasswordData object with the input values
                PasswordData passwordData = PasswordData(
                  account: account,
                  mailId: mailId,
                  password: password,
                  url: url,
                );

                // Insert the password data into the database
                await PasswordDatabase.instance.insertPassword(passwordData);

                // Clear the text fields after submission
                accountController.clear();
                mailIdController.clear();
                passwordController.clear();
                urlController.clear();

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
