import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/redux/reducer.dart';
import 'package:redux/redux.dart';

import 'loadingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final Store<AppState> store = Store(getUid, initialState: AppState(uid: ""));
  runApp(StoreProvider(
    store: store,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Patrick"),
      home: LoadingPage(),
    ),
  ));
}
