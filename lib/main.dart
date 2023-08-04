import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/redux/reducer.dart';
import 'package:notesapp/utils/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'loadingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final Store<AppState> store = Store(getUser, initialState: AppState(user: null));
  runApp(StoreProvider(
    store: store,
    child: ChangeNotifierProvider(
      create: (BuildContext context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Patrick"),
        home: ChangeNotifierProvider(create: (BuildContext context) => Auth(),
        child: const LoadingPage()),
      ),
    ),
  ));
}
