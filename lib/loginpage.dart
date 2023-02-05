import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/otppage.dart';

import 'backgroundtheme.dart';

class LoginPage extends StatelessWidget {
  TextEditingController phone = TextEditingController();
  final input = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              // todo back ground
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffff5858),
              child: CustomPaint(
                painter: BackgroundTheme(),
              ),
            ),
            Positioned(
              top: (Offset(MediaQuery.of(context).size.width * 0.5,0) - Offset(MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.height * 0.3)).distance
                  - (MediaQuery.of(context).size.height * 0.1),
                      // - (MediaQuery.of(context).size.height * 0.3),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/verify.gif",
                    height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.height * 0.2,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mobile Number",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold,),),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: input,
                      child: TextFormField(
                        style: const TextStyle(letterSpacing: 4,fontFamily: "Roboto"),
                        validator: (num){
                          if( num == null || num.isEmpty){
                            return "Enter mobile number.";
                          }
                        },
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        controller: phone,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            gapPadding: 20
                          ),
                          hintText: ("+91"),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    icon: const Icon(Icons.password_outlined,color: Colors.black),
                    onPressed: () {
                      if(input.currentState!.validate()){
                        FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phone.text.contains("+91")
                                ? phone.text
                                : '+91${phone.text}',
                            verificationFailed: (FirebaseAuthException error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Incorrect number.${error.message.toString()}")));
                            },
                            verificationCompleted:
                                (PhoneAuthCredential phoneAuthCredential) {
                              print('ok verify');
                            },
                            codeSent: (String verificationId,
                                int? forceResendingToken) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("OTP sent.")));
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (_) => OTPPage(
                                        verifyID: verificationId,
                                      )));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                            timeout: const Duration(seconds: 10));
                      }
                    },
                    label: const Text("Get OTP",style: TextStyle(color: Colors.black),),
                    // shape: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
