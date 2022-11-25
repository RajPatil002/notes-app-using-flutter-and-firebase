import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/otppage.dart';

class LoginPage extends StatelessWidget {
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: phone,
                decoration: const InputDecoration(border: OutlineInputBorder(),
                  hintText: ("+91")
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${phone.text}',
                      verificationFailed: (FirebaseAuthException error) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect number.")));
                      },
                      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) { print('ok verify'); },
                      codeSent: (String verificationId, int? forceResendingToken) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP sent.")));
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => OTPPage(verifyID: verificationId,)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {  },
                      timeout: const Duration(minutes: 3)
                    );
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
