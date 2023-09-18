import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/firestore/datastore.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';

import 'package:notesapp/backgroundtheme.dart';

class EditorPage extends StatefulWidget {
  final String id;

  const EditorPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Timer? _titletimer, _messagetimer;

  final TextEditingController _message = TextEditingController();

  final TextEditingController _title = TextEditingController();
  Map<String, dynamic>? note;
  late Datastore datastore;
  @override
  void initState() {
    final uid = StoreProvider.of<AppState>(context, listen: false).state.user!.uid;
    datastore = Datastore(uid: uid);
    datastore.fetchNote(noteid: widget.id).then((note) {
      setState(() {
        this.note = note;
        _message.text = note[Database.message];
        _title.text = note[Database.title];
        _message.selection = TextSelection.fromPosition(TextPosition(offset: _message.text.length));
        _title.selection = TextSelection.fromPosition(TextPosition(offset: _title.text.length));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    datastore.updateNote(message: _message.text, title: _title.text, noteid: widget.id).then((_) {
      _message.dispose();
      _title.dispose();
      _titletimer?.cancel();
      _messagetimer?.cancel();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffff5858),
        child: CustomPaint(
            painter: BackgroundTheme(),
            child: (note != null)
                ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            onTap: () => _title.text == 'Untitled'
                                ? _title.selection = TextSelection(baseOffset: 0, extentOffset: _title.text.length)
                                : null,
                            controller: _title,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                hintText: 'Enter your Note',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none, borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
                            onChanged: (_) async {
                              debounceTitle(() {
                                datastore.updateNoteTitle(title: _title.text, noteid: widget.id);
                              });
                            },
                            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
                                  filled: true,
                                  hintText: 'Enter your Note',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))),
                              style: const TextStyle(fontSize: 30),
                              // autofocus: true,
                              controller: _message,
                              keyboardType: TextInputType.multiline,
                              maxLines: 55,
                              onChanged: (_) async {
                                debounceMessage(() {
                                  datastore.updateNoteMessage(message: _message.text, noteid: widget.id);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        _titletimer?.cancel();
                        _messagetimer?.cancel();
                        datastore
                            .updateNote(message: _message.text, title: _title.text, noteid: widget.id)
                            .then((value) => Navigator.pop(context));
                      },
                      backgroundColor: const Color(0xff01bff9),
                      child: const Icon(Icons.done),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )),
      ),
    );
  }

  debounceTitle(void Function() callback) async {
    _titletimer?.cancel();
    _titletimer = Timer(const Duration(seconds: 5), callback);
  }

  debounceMessage(void Function() callback) async {
    _messagetimer?.cancel();
    _messagetimer = Timer(const Duration(seconds: 5), callback);
  }
}
