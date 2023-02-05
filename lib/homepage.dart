import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/backgroundtheme.dart';
import 'package:notesapp/editorpage.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/redux/reducer.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MediaQuery(
      data: const MediaQueryData(
        size: Size.infinite,
      ),
      child: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  child: Text(
                    "Welcome to Notes",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
                Expanded(
                  child: StoreConnector<AppState, String>(
                    converter: (store) => store.state.uid,
                    builder: (context, uid) => StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users/$uid/Notes')
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> notes) {
                        // print(notes.data?.docs[0].id +"");
                        if (notes.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: notes.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DateTime date = DateTime.parse(
                                    "${notes.data?.docs[index].id.toString()}");
                                return Padding(
                                  // padding: const EdgeInsets.only(left: 15,right: 15,),
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {
                                      // todo
                                      // print(notes.data!.docs[index].id.length);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => EditorPage(
                                                  date: notes
                                                      .data!.docs[index].id
                                                      .toString())));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    notes.data?.docs[index]
                                                        ["Title"],
                                                    style: const TextStyle(
                                                        fontSize: 23),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        const Color(0xffff5858),
                                                    child: IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        //  todo
                                                      },
                                                      // elevation: 20,
                                                      icon: const Icon(
                                                          Icons.delete_forever),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            // const SizedBox(height: 20,),
                                            Expanded(
                                              flex: 3,
                                              child: Text(notes.data
                                                  ?.docs[index]["Message"]),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        DateFormat(
                                                                "MMM dd yyyy")
                                                            .format(date),
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        DateFormat("HH:mm")
                                                            .format(date),
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        const Color(0xff01bff9),
                                                    radius: 25,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        // TODO
                                                      },
                                                      color: Colors.white,
                                                      icon: const Icon(
                                                          Icons.edit),
                                                    ),
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
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            SharedPreferences.getInstance().then((value) => value.setString("uid", ""));
          },
        backgroundColor: const Color(0xff01bff9),
          label: const Text("Logout"),
          icon: const Icon(Icons.logout),
      ),
    );
  }
}
