import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/firestore/datastore.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';

import 'backgroundtheme.dart';

// main() => runApp(
//   MaterialApp(home: EditorPage())
// );

class EditorPage extends StatefulWidget {
  final String id;

  const EditorPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Timer? _timer;

  final TextEditingController _message = TextEditingController();

  final TextEditingController _title = TextEditingController();

  late Datastore data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User?>(
      converter: (store) => store.state.user,
      builder: (context, user) {
        data = Datastore(uid: user!.uid);
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                FutureBuilder<Map<String, dynamic>?>(
                  future: data.fetchNote(noteid: widget.id),
                  builder: (context, notedata) {
                    if (notedata.hasData && notedata.data != null) {
                      Map<String, dynamic> note = notedata.data!;
                      _message.text = note[Database.message];
                      _title.text = note[Database.title];
                      _message.selection = TextSelection.fromPosition(TextPosition(offset: _message.text.length));
                      _title.selection = TextSelection.fromPosition(TextPosition(offset: _title.text.length));
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
                                  border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
                              onChanged: (_) async {
                                debounce(() {
                                  // todo update title
                                  // FirebaseFirestore.instance.doc("Users/${user!.uid}/Notes/$id").update({Database.title: _title.text});
                                  data.updateNoteTitle(title: _title.text, noteid: widget.id);
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
                                    border: OutlineInputBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))),
                                style: const TextStyle(fontSize: 22),
                                // autofocus: true,
                                controller: _message,
                                keyboardType: TextInputType.multiline,
                                maxLines: 55,
                                onChanged: (_) async {
                                  debounce(() {
                                    // todo update message
                                    // FirebaseFirestore.instance
                                    //     .doc("Users/${user.uid}/Notes/$id")
                                    //     .update({Database.message: _message.text});
                                    data.updateNoteMessage(message: _message.text, noteid: widget.id);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _timer?.cancel();
                // todo update note
                // FirebaseFirestore.instance.collection("Users/${user!.uid}/Notes").update({Database.title: _title.text, Database.message: _message.text,"date":date});
              },
              backgroundColor: const Color(0xff01bff9),
              child: const Icon(Icons.done),
            ),
          ),
        );
      },
    );
  }

  debounce(callback) async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      callback();
    });
  }
}
