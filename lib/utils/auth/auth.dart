import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/actions.dart';
import '../../redux/appstate.dart';
import '../firestore/datastore.dart';

class Auth {
  User? user;
  final fireauth = FirebaseAuth.instance;
  Auth({this.user}) {
    // user = fireauth.currentUser;
    fireauth.authStateChanges().listen((result) {
      // print("asdasdasdasda" + result.toString());
      user = result;
    });
  }

  verifyOTP({required String verifyID, required String otp, required BuildContext context}) {
    print(verifyID);
    try {
      FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verifyID, smsCode: otp)).then((result) {
        user = result.user;
        Datastore().addUserIfNotExist(user: user);
        StoreProvider.of<AppState>(context).dispatch(UpdateUser(user: result.user));
      });
      // String uid = result.user!.uid;
      // print("${uq}");
      // SharedPreferences.getInstance().then((value) => value.setString("uid", uid));
      // await FirebaseAuth.instance.setSettings(
      //     appVerificationDisabledForTesting: true, forceRecaptchaFlow: true);
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    } on FirebaseAuthException {
      // ScaffoldMessenger.of(context)
      // .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
      rethrow;
    }
  }

  Future<User?> logOut() async {
    // user = null;
    await fireauth.signOut();
    return fireauth.currentUser;
  }
}
