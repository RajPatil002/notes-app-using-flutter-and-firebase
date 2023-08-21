import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../homepage.dart';
import '../loginpage.dart';
import '../redux/appstate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        builder: (context, state) {
          if (state.user != null) {
            print("wrapper");
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
        converter: (store) => store.state);
  }
}
