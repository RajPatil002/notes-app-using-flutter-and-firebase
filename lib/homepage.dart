import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
        builder: (context,notes){
          return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
            // itemCount: notes.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card();
            },
          );
        },
      ),
    );
  }
}
