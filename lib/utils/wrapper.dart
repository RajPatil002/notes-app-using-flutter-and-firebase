import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../homepage.dart';
import '../loginpage.dart';
import '../redux/actions.dart';
import '../redux/appstate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  static User? isLogged() {
    final auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = isLogged();
    if (user != null) {
      StoreProvider.of<AppState>(context).dispatch(UpdateUser(user: user));
      return const HomePage();
    } else {
      return LoginPage();
    }
  }
}
