import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController _titleController = TextEditingController();

  Future<void> _uploadBook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      PlatformFile file = result.files.first;
      // Upload PDF to Firebase Storage and Firestore
      UploadTask uploadTask = FirebaseStorage.instance.ref('books/${file.name}').putFile(File(file.path!));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('books').add({
        'title': _titleController.text,
        'url': downloadUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book uploaded successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadBook,
              child: Text('Upload Book'),
            ),
          ],
        ),
      ),
    );
  }
}
