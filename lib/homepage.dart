import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/backgroundtheme.dart';
import 'package:notesapp/editorpage.dart';
import 'package:notesapp/note_card.dart';
import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/firestore/datastore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late Datastore data;
  late Animation<Offset> _animation;
  late AnimationController _animationController;
  int count = 0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      builder: (context, state) {
        data = Datastore(uid: state.user!.uid);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffff5858),
            child: CustomPaint(
              painter: BackgroundTheme(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    // padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Text(
                            "Welcome to Notes",
                            style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff01bff9),
                          ),
                          child: IconButton(
                              onPressed: () => (data.createNote())
                                  .then((id) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditorPage(id: id)))),
                              iconSize: 30,
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xffff5858),
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: data.fetchStreamNotes(),
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> notessnapshot) {
                        // print('notes[0].id +${notessnapshot.data!.docs}');
                        if (notessnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (notessnapshot.hasData && notessnapshot.data != null) {
                          List<Map<String, dynamic>> notes = notessnapshot.data!.docs
                              .map((note) => {
                                    "id": note.id,
                                    'data': note.data(),
                                  })
                              .toList();
                          _animationController.forward();
                          return SlideTransition(
                            position: _animation,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: MasonryGridView.builder(
                                  // direction: Axis.vertical,
                                  // crossAxisAlignment: WrapCrossAlignment.start,
                                  itemCount: notes.length,
                                  itemBuilder: (context, index) {
                                    return NoteCard(
                                      id: notes[index]['id'],
                                      data: notes[index]['data'],
                                      datastore: data,
                                    );
                                  },
                                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                )),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Add Notes",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              state.auth.logOut();
              StoreProvider.of<AppState>(context).dispatch(UpdateUser());
            },
            backgroundColor: const Color(0xff01bff9),
            label: const Text("Logout"),
            icon: const Icon(Icons.logout),
          ),
        );
      },
      converter: (store) => store.state,
    );
  }
}
