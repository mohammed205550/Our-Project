import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_univercity/admin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Library'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var books = snapshot.data!.docs;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(books[index]['title']),
                onTap: () {
                 },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to admin panel
          Navigator.push( context, MaterialPageRoute(builder: (context) =>AdminPanel()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
