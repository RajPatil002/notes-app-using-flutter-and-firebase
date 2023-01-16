import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// main() => runApp(
//   MaterialApp(home: EditorPage())
// );

class EditorPage extends StatelessWidget {
  final String uid;
  final String date;
  TextEditingController message  = TextEditingController();

  EditorPage({Key? key,required this.uid,required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
      future: FirebaseFirestore.instance.collection("User/${uid}/Notes").doc(date).get(),
      builder: (context, notedata) {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$date ${notedata.data?.data().toString()}");
        // Map<String,dynamic> map = notedata.data?.data() as Map<String,dynamic>;
        if(notedata.hasData){
          return Text("{map.toString()}");
        }
        return Center(child: CircularProgressIndicator(),);
      },
      // child: Scaffold(
      //   body: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: TextField(
      //       decoration: const InputDecoration(
      //         hintText: 'Enter your Note',
      //         border: InputBorder.none
      //       ),
      //       style: const TextStyle(
      //         fontSize: 22
      //       ),
      //       autofocus: true,
      //       controller: message,
      //       keyboardType: TextInputType.multiline,
      //       maxLines: 55,
      //       onChanged: (message){
      //         if(message.isNotEmpty){
      //           // print(this.message.text);
      //           // TODO
      //         }
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
