import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/backgroundtheme.dart';
import 'package:notesapp/editorpage.dart';
import 'package:notesapp/note_paper.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';
import 'package:notesapp/utils/firestore/datastore.dart';

class ViewPage extends StatefulWidget {
  final String id;
  const ViewPage({super.key, required this.id});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  // late AnimationController _controller;
  late Datastore _dataStore;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.user!.uid,
      // converter: (store) => store.state.user!.uid,
      builder: (context, String uid) {
        _dataStore = Datastore(uid: uid);
        return CustomPaint(
          painter: BackgroundTheme(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EditorPage(id: widget.id))),
                    iconSize: 50,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () => _dataStore.deleteNote(noteid: widget.id).then((value) => Navigator.pop(context)),
                    iconSize: 50,
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    )),
                // true
                //     ? const IconButton(
                //         onPressed: null,
                //         iconSize: 50,
                //         icon: Icon(
                //           Icons.save,
                //           color: Colors.white,
                //         ))
                //     : Container(),
              ],
            ),
            body: Center(
              child: FutureBuilder(
                  future: _dataStore.fetchNote(noteid: widget.id),
                  builder: (context, AsyncSnapshot<Map<String, dynamic>> note) {
                    if (note.connectionState != ConnectionState.waiting && note.hasData) {
                      // _controller.forward();

                      return Center(
                          child: NotePaper(
                        title: note.data![Database.title],
                        message: note.data![Database.message],
                      ));
                    } else {
                      return const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
        );
      },
    );
  }
}
