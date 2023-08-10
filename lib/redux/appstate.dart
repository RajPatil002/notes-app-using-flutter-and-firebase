import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/utils/auth/auth.dart';

class AppState {
  User? user;
  late Auth auth;
  AppState({this.user}) {
    print(user);
    auth = Auth(user: user);
  }
}
