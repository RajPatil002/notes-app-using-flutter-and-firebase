import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/homepage.dart';

class OTPPage extends StatefulWidget {
  final String verifyID;
  const OTPPage({Key? key,required this.verifyID}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {

  TextEditingController pin1 = TextEditingController();

  TextEditingController pin2 = TextEditingController();

  TextEditingController pin3 = TextEditingController();

  TextEditingController pin4 = TextEditingController();

  TextEditingController pin5 = TextEditingController();

  TextEditingController pin6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin1,
                        onTap: () {
                          pin1.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            pin1.text = num;
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin2,
                        onTap: () {
                          pin2.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            pin2.text = num;
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin3,
                        onTap: () {
                          pin3.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            pin3.clear();
                            pin3.text = num;
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin4,
                        onTap: () {
                          pin4.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            pin4.clear();
                            pin4.text = num;
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin5,
                        onTap: () {
                          pin5.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            pin5.clear();
                            pin5.text = num;
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pin6,
                        onTap: () {
                          pin6.clear();
                        },
                        cursorHeight: 0,
                        cursorWidth: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (num) {
                          if (num.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),//otp fields
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FloatingActionButton(
                onPressed: () async {
                  try{
                     UserCredential result = await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: widget.verifyID, smsCode: "${pin1.text}${pin2.text}${pin3.text}${pin4.text}${pin5.text}${pin6.text}"
                     ));
                     User? u = result.user;
                     print("${u?.uid} ${u?.phoneNumber}");

                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage(uid: u?.uid,)));
                  } on FirebaseAuthException {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
                  }
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ),//button for login
        ],
      ),
    );
  }
}
