

import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';

AppState getUid(AppState old,dynamic act){
  return act is UpdateUid? AppState(uid: act.uid):old;
}