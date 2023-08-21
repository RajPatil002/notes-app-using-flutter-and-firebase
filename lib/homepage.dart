import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/backgroundtheme.dart';
import 'package:notesapp/editorpage.dart';
import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/firestore/datastore.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late Datastore data;
  late Animation<Offset> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data.fetchStreamNotes().drain();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      builder: (context, state) {
        print("fffffff");
        data = Datastore(uid: state.user!.uid);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffff5858),
                child: CustomPaint(
                  painter: BackgroundTheme(),
                ),
              ),
              Column(
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
                              onPressed: () async {
                                print(await data.createNote());
                              },
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
                      // future: data.fetchNotes(),
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> notessnapshot) {
                        print('notes[0].id +""');
                        if (notessnapshot.hasData && notessnapshot.data != null) {
                          List<Map<String, dynamic>> notes = notessnapshot.data!.docs
                              .map((note) => {
                                    "id": note.id,
                                    'data': note.data(),
                                  })
                              .toList();
                          _animationController.reset();
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
                                    // int index = 0;
                                    // print("ssdasa" + notes[index]['id']);
                                    DateTime date = notes[index]['data']['Date'].toDate();
                                    // DateTime.parse("${.toString()}");
                                    return Padding(
                                      // padding: const EdgeInsets.only(left: 15,right: 15,),
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          // todo
                                          // print(notes[index].id.length);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (_) => EditorPage(id: notes[index]['id'])));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          elevation: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  // mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      notes[index]['data'][Database.title],
                                                      style: const TextStyle(fontSize: 23),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: const Color(0xffff5858),
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        onPressed: () async {
                                                          //  todo delete
                                                          await getConfirmation(title: notes[index]['data'][Database.title])
                                                              .then((result) {
                                                            result ? data.deleteNote(noteid: notes[index]['id']) : null;
                                                          });
                                                          // print(result);
                                                        },
                                                        // elevation: 20,
                                                        icon: const Icon(Icons.delete_forever),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                // const SizedBox(height: 20,),
                                                Text(
                                                  notes[index]['data'][Database.message],
                                                  maxLines: 10,
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                ),
                                                Row(
                                                  // mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          DateFormat("MMM dd yyyy").format(date),
                                                          style: const TextStyle(fontSize: 15),
                                                        ),
                                                        Text(
                                                          DateFormat.jm().format(date),
                                                          style: const TextStyle(fontSize: 10, letterSpacing: 1),
                                                        )
                                                      ],
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: const Color(0xff01bff9),
                                                      radius: 25,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          // TODO edit
                                                        },
                                                        color: Colors.white,
                                                        icon: const Icon(Icons.edit),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // SharedPreferences.getInstance().then((value) => value.setString("uid", ""));
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

  getConfirmation({required String title}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          title: const Text("Delete"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text("Do you want to delete this note?"), Text(title)],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes")),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No")),
          ],
        );
      });
}
