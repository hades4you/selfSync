import 'package:flutter/material.dart';
import 'package:selfsync/memoDatabase.dart';

class NewMemoScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Memo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Content',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Save the memo to the database
                await MemoDatabase.instance.insertMemo(
                  MemoData(
                    title: _titleController.text,
                    content: _contentController.text,
                  ),
                );
                // Go back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Save Memo'),
            ),
          ],
        ),
      ),
    );
  }
}
