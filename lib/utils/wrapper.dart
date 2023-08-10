import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import '../homepage.dart';
import '../loginpage.dart';
import '../redux/actions.dart';
import '../redux/appstate.dart';
import 'auth/auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<Auth>(context);
    // print(state.user);
    return StoreConnector<AppState, AppState>(
        builder: (context, state) {
          // final user = state.auth.isLogged();
          if (state.user != null) {
            // StoreProvider.of<AppState>(context).dispatch(UpdateUser(user: user));
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
        converter: (store) => store.state);
  }
}
