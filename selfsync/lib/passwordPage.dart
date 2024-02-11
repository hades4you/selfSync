import 'package:flutter/material.dart';
import 'package:selfsync/passwordDatabase.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late Future<List<PasswordData>> _passwordsFuture;

  @override
  void initState() {
    super.initState();
    _passwordsFuture = PasswordDatabase.instance.getPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwords'),
      ),
      body: FutureBuilder<List<PasswordData>>(
        future: _passwordsFuture,
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
            List<PasswordData> passwords = snapshot.data ?? [];
            return ListView.builder(
              itemCount: passwords.length,
              itemBuilder: (context, index) {
                PasswordData password = passwords[index];
                return ListTile(
                  title: Text(password.account),
                  subtitle: Text(password.mailId),
                  trailing: Icon(Icons.lock), // Placeholder for lock icon
                  onTap: () {
                    // Show a dialog with the password and delete option
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Password'),
                          content: Text(password.password),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                // Delete password entry
                                await PasswordDatabase.instance
                                    .deletePassword(password.id!);
                                // Close the dialog
                                Navigator.pop(context);
                                // Update the passwords list
                                setState(() {
                                  _passwordsFuture =
                                      PasswordDatabase.instance.getPasswords();
                                });
                              },
                              child: Text('Delete'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
