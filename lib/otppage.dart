import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/homepage.dart';
import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/redux/reducer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backgroundtheme.dart';


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
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/password.gif",
                  height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.height * 0.2,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("OTP",style: TextStyle(fontSize: 30,color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
                            child: TextFormField(
                              controller: pin1,
                              onTap: () {
                                pin1.clear();
                              },
                              autofocus: true,
                              cursorHeight: 0,
                              cursorWidth: 0,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  pin1.text = value;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
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
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  pin2.text = value;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
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
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  pin3.clear();
                                  pin3.text = value;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
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
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  pin4.clear();
                                  pin4.text = value;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
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
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  pin5.clear();
                                  pin5.text = value;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
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
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),//ot
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.verified,color: Colors.black),
                  onPressed: () async {
                    try{
                      UserCredential result = await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: widget.verifyID, smsCode: "${pin1.text}${pin2.text}${pin3.text}${pin4.text}${pin5.text}${pin6.text}"
                      ));
                      String uid = result.user!.uid;
                      StoreProvider.of<AppState>(context).dispatch(UpdateUid(uid));
                      // print("${uq}");
                      SharedPreferences.getInstance().then((value) => value.setString("uid", uid));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                    } on FirebaseAuthException {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
                    }
                  },
                  label: const Text("Check",style: TextStyle(color: Colors.black),),
                  // shape: const Icon(Icons.arrow_forward),
                ),// p fields
                // Align(
                //   alignment: AlignmentDirectional.bottomEnd,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 20.0),
                //     child: FloatingActionButton(
                //       onPressed: () async {
                //         try{
                //           UserCredential result = await FirebaseAuth.instance
                //               .signInWithCredential(PhoneAuthProvider.credential(
                //               verificationId: widget.verifyID, smsCode: "${pin1.text}${pin2.text}${pin3.text}${pin4.text}${pin5.text}${pin6.text}"
                //           ));
                //           User? u = result.user;
                //           print("${u?.uid} ${u?.phoneNumber}");
                //
                //           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage(uid: u?.uid,)));
                //         } on FirebaseAuthException {
                //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
                //         }
                //       },
                //       child: const Icon(Icons.arrow_forward),
                //     ),
                //   ),
                // ),//button for login
              ],
            ),
          ),
        ],
      ),
    );
  }
}
