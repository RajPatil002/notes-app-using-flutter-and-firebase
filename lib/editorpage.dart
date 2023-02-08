import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/appstate.dart';

import 'backgroundtheme.dart';

// main() => runApp(
//   MaterialApp(home: EditorPage())
// );

class EditorPage extends StatelessWidget {
  final String date;
  Timer? _timer;
  final TextEditingController _message = TextEditingController();
  final TextEditingController _title = TextEditingController();

  EditorPage({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.uid,
      builder: (context, uid) => Scaffold(
        body: Stack(
          children: [
            Container(
              // todo back ground
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffff5858),
              child: CustomPaint(
                painter: BackgroundTheme(),
              ),
            ),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection("Users/$uid/Notes")
                  .doc(date)
                  .get(),
              builder: (context, notedata) {
                // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${date}aaaaaaaaaaaaaaaaaaaa${notedata.data?.data().toString()}");
                if (notedata.connectionState != ConnectionState.waiting) {
                  if (notedata.hasData) {
                    Map<String, dynamic> note =
                        notedata.data?.data() as Map<String, dynamic>;
                    _message.text = note['Message'];
                    _title.text = note['Title'];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _title,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter your Note',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)
                                    )
                                )
                            ),
                            onChanged: (_) async {
                              debounce(() {
                                // todo update title
                                FirebaseFirestore.instance
                                    .doc("Users/$uid/Notes/$date")
                                    .update({"Title": _title.text});
                              });
                            },
                            style: const TextStyle(fontSize: 30),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your Note',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20)
                                    )
                                  )
                              ),
                              style: const TextStyle(fontSize: 22),
                              // autofocus: true,
                              controller: _message,
                              keyboardType: TextInputType.multiline,
                              maxLines: 55,
                              onChanged: (_) async {
                                debounce(() {
                                  // todo update message
                                  FirebaseFirestore.instance
                                      .doc("Users/$uid/Notes/$date")
                                      .update({"Message": _message.text});
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _timer?.cancel();
            FirebaseFirestore.instance
                .doc("Users/$uid/Notes/$date")
                .update({"Title": _title.text, "Message": _message.text});
          },
          backgroundColor: const Color(0xff01bff9),
          child: const Icon(Icons.done),
        ),
      ),
    );
  }

  debounce(callback) async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      callback();
    });
  }
}
