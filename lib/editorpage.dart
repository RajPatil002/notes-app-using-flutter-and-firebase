import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/appstate.dart';

// main() => runApp(
//   MaterialApp(home: EditorPage())
// );

class EditorPage extends StatelessWidget {
  final String date;
  final TextEditingController _message  = TextEditingController();
  final TextEditingController _title  = TextEditingController();

  EditorPage({Key? key,required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,String>(
      converter: (store) => store.state.uid,
      builder: (context,uid) => FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: FirebaseFirestore.instance.collection("Users/$uid/Notes").doc(date).get(),
        builder: (context, notedata) {
          // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${date}aaaaaaaaaaaaaaaaaaaa${notedata.data?.data().toString()}");
          if(notedata.connectionState != ConnectionState.waiting){
            if(notedata.hasData){
              Map<String,dynamic> note = notedata.data?.data() as Map<String,dynamic>;
              _message.text = note['Message'];
              _title.text = note['Title'];
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _title,
                        style: const TextStyle(
                            fontSize: 30
                        ),
                        maxLines: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Enter your Note',
                                border: InputBorder.none
                            ),
                            style: const TextStyle(
                                fontSize: 22
                            ),
                            autofocus: true,
                            controller: _message,
                            keyboardType: TextInputType.multiline,
                            maxLines: 55,
                            onChanged: (message){
                              if(message.isNotEmpty){
                                // print(this.message.text);
                                // TODO
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
