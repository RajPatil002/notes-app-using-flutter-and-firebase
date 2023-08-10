import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';

AppState updateState(AppState old, dynamic act) {
  if (act is UpdateUser) {
    old.user = act.user;
  }
  return old;
}
