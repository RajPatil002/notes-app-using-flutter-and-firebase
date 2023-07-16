import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';

AppState getUser(AppState old, dynamic act) {
  return act is UpdateUser ? AppState(user: act.user) : old;
}
