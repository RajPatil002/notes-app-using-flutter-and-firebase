import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  FirebaseFirestore storeinstance = FirebaseFirestore.instance;
  addUserIfNotExist({required User? user}) {
    final DocumentReference userdoc = storeinstance.doc("/Users/${user!.uid}");
    userdoc.get().then((value) {
      if (!value.exists) {
        addUser(userdoc, mobile: user.phoneNumber);
      }
    });
  }

  static addUser(DocumentReference doc, {required String? mobile}) {
    doc.set({'mobile': mobile});
    doc.collection("Notes").add({});
  }

  Future<List> fetchNotes({required String uid}) async {
    return await storeinstance
        .collection("Users/$uid/Notes")
        .get()
        .then((documents) => documents.docs.map((note) => note.data()).toList());
  }
}
