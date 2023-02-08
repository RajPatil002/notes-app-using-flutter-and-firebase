import 'package:shared_preferences/shared_preferences.dart';
class Wrapper {
  static Future<String> isLogged() async {
    final inst = await SharedPreferences.getInstance();
    String? uid = inst.getString("uid");
    if (uid != null && uid.isNotEmpty) {
      return uid;
    }
    return "";
  }
}