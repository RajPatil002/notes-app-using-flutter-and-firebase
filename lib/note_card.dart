import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';
import 'package:notesapp/utils/firestore/datastore.dart';
import 'package:notesapp/viewpage.dart';
import 'package:notesapp/editorpage.dart';

class NoteCard extends StatefulWidget {
  final String id;
  final Datastore datastore;
  final Map<String, dynamic> data;
  const NoteCard({super.key, required this.id, required this.data, required this.datastore});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late DateTime date;

  @override
  void initState() {
    date = widget.data['Date'].toDate();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewPage(id: widget.id))),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: _animationController, curve: Curves.easeOutExpo),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 2),
                        )),
                        child: Text(
                          widget.data[Database.title],
                          style: const TextStyle(fontSize: 23),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xffff5858),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () async {
                            getConfirmation().then((value) {
                              if (value == true) {
                                widget.datastore.deleteNote(noteid: widget.id);
                              }
                            });
                          },
                          icon: const Icon(Icons.delete_forever),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    widget.data[Database.message],
                    maxLines: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
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
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditorPage(id: widget.id))),
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
      ),
    );
  }

  Future<bool?> getConfirmation() => showDialog<bool>(
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
              children: [
                const Text("Do you want to delete this note?"),
                Text(
                  widget.data[Database.title],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
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
