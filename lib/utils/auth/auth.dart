import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/actions.dart';
import '../../redux/appstate.dart';

class Auth extends ChangeNotifier {
  User? user;
  final fireauth = FirebaseAuth.instance;
  Auth() {
    user = fireauth.currentUser;
    fireauth.authStateChanges().listen((result) {
      print(result);
      user = result;
    });
  }

  User? isLogged() => user;

  String? verID;
  Future<String?> requestOTP(phone) async {
    await fireauth
        .verifyPhoneNumber(
            phoneNumber: phone,
            verificationFailed: (FirebaseAuthException error) {
              print(error);
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text("Incorrect number.${error.message.toString()}")));
            },
            verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
              print('ok verify');
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP sent.")));
              verID = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
            timeout: const Duration(seconds: 10))
        .onError((error, stackTrace) => error);
    return verID;
  }

  verifyOTP(verifyID, otp, context) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verifyID, smsCode: otp));
      // String uid = result.user!.uid;
      print("sssssssss ${result.user}");
      user = result.user;
      StoreProvider.of<AppState>(context).dispatch(UpdateUser(user: result.user));
      notifyListeners();
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

  void logOut() {
    user = null;
    // user = null;
    fireauth.signOut();

    notifyListeners();
  }
}
