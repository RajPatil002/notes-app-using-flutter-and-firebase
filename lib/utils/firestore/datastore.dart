import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/utils/firestore/database_structure.dart';

class Datastore {
  FirebaseFirestore storeinstance = FirebaseFirestore.instance;
  String? uid;

  Datastore({this.uid});

  Map<String, dynamic> _getMap({title = "Untitled", message = ""}) => {Database.title: title, Database.message: message};

  addUserIfNotExist({required User? user}) {
    final DocumentReference userdoc = storeinstance.doc("/Users/${user!.uid}");
    userdoc.get().then((userdata) {
      if (!userdata.exists) {
        addUser(userdoc, mobile: user.phoneNumber);
      }
    });
  }

  addUser(DocumentReference doc, {required String? mobile}) {
    doc.set({'mobile': mobile});
    doc.collection("Notes").add(_getMap(title: "Sample", message: "This is Sample Note"));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchStreamNotes() =>
      storeinstance.collection("Users/$uid/Notes").orderBy(Database.date).snapshots();

  Future<List<Map<String, dynamic>>> fetchNotes() {
    return storeinstance.collection("Users/$uid/Notes").get().then((documents) => documents.docs
        .map((note) => {
              "id": note.id,
              'data': note.data(),
            })
        .toList());
  }

  Future<Map<String, dynamic>?> fetchNote({required String noteid}) {
    return storeinstance.doc("Users/$uid/Notes/$noteid").get().then((documents) => documents.data());
  }

  void updateNoteTitle({required String title, required String noteid}) {
    storeinstance.doc("Users/$uid/Notes/$noteid").update({
      Database.title: title,
    });
  }

  void updateNoteMessage({required String message, required String noteid}) {
    storeinstance.doc("Users/$uid/Notes/$noteid").update({
      Database.message: message,
    });
  }

  Future<String> createNote() async {
    Map<String, dynamic> create = _getMap();
    create[Database.date] = DateTime.now();
    return (await storeinstance.collection("Users/$uid/Notes/").add(create)).id;
  }

  Future<void> deleteNote({required String noteid}) async {
    storeinstance.collection("Users/$uid/Notes/").doc(noteid).delete();
  }
}
