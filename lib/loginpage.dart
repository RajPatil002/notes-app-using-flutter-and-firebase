import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/redux/appstate.dart';

import 'backgroundtheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phone = TextEditingController();

  Color valid = const Color(0xFF7C4DFF);

  final List<TextEditingController> pins = List.generate(6, (index) => TextEditingController());

  final phonekey = GlobalKey<FormState>();

  final otpkey = GlobalKey<FormState>();

  bool isresend = false;
  int time = 0;
  late Timer timer;
  String verificationId = "";

  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of<Auth>(context, listen: false);
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                print(verificationId);
              },
            ),
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
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Form(
                        key: phonekey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            style: const TextStyle(letterSpacing: 4, fontFamily: "Roboto"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter mobile number.";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\+"))],
                            autofocus: true,
                            controller: phone,
                            onChanged: (value) {
                              if ((value.length == 10 && !value.startsWith('+91') && !value.contains('+')) ||
                                  (value.length == 13 && '+'.allMatches(value).length == 1 && value.startsWith('+91'))) {
                                setState(() {
                                  valid = const Color(0xFF00C853);
                                });
                              } else {
                                // setState(() {
                                //   valid = const Color(0xFFEF5350);
                                // });
                              }
                            },
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30), gapPadding: 20, borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  gapPadding: 20,
                                  borderSide: BorderSide(color: valid, width: 3)),
                              hintText: ("+91"),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: otpkey,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.080,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.125,
                                  padding: const EdgeInsets.only(left: 7, right: 7),
                                  // decoration:
                                  //     BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
                                  child: TextFormField(
                                    controller: pins[index],
                                    onTap: () {
                                      pins[index].clear();
                                    },
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        pins[index].text = value;
                                        if (index < pins.length - 1) {
                                          if (pins[index + 1].text.isEmpty) {
                                            FocusScope.of(context).nextFocus();
                                          } else {
                                            FocusScope.of(context).unfocus();
                                          }
                                        }
                                      }
                                    },
                                    onTapOutside: (_) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    validator: (String? pin) {
                                      if (pin == null || pin.isEmpty) {
                                        return "";
                                      }
                                      return null;
                                    },
                                    autofocus: true,
                                    cursorHeight: 0,
                                    cursorWidth: 0,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 3)),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                );
                              },
                              itemCount: pins.length,
                            )),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: isclicked
                                ? const FloatingActionButton(
                                    onPressed: null,
                                    heroTag: null,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                                  )
                                : FloatingActionButton.extended(
                                    backgroundColor: Colors.white,
                                    heroTag: null,

                                    icon: time != 0
                                        ? const Icon(Icons.timer_outlined, color: Colors.brown)
                                        : const Icon(Icons.password_outlined, color: Colors.redAccent),
                                    onPressed: time != 0
                                        ? null
                                        : () async {
                                            FocusScope.of(context).unfocus();
                                            if (phonekey.currentState!.validate()) {
                                              // setState(() {
                                              //   isclicked = true;
                                              // });

                                              await state.auth.fireauth
                                                  .verifyPhoneNumber(
                                                      phoneNumber: phone.text.contains("+91") ? phone.text : '+91${phone.text}',
                                                      verificationFailed: (FirebaseAuthException error) {
                                                        print("eeeeeeeee$error");
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(SnackBar(content: Text("Incorrect number.${error.message.toString()}")));
                                                      },
                                                      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
                                                        print('ok verify');
                                                      },
                                                      codeSent: (String verificationId, int? forceResendingToken) {
                                                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP sent.")));
                                                        print("$verificationId           + $forceResendingToken");
                                                        this.verificationId = verificationId;
                                                      },
                                                      codeAutoRetrievalTimeout: (String verificationId) {},
                                                      timeout: const Duration(seconds: 10))
                                                  .onError((error, stackTrace) => print("ssssssssssss$error"));
                                              // setState(() {
                                              //   isclicked = false;
                                              // });
                                              time = 5;
                                              timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
                                                if (time == 0) {
                                                  timer.cancel();
                                                } else {
                                                  setState(() {
                                                    time--;
                                                  });
                                                }
                                              });
                                            }
                                          },
                                    label: Text(
                                      time != 0 ? "${time}s Resend" : "Get OTP",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    // shape: const Icon(Icons.arrow_forward),
                                  ),
                          ),
                          //button for login
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FloatingActionButton.extended(
                              heroTag: null,
                              backgroundColor: Colors.white,
                              icon: Icon(Icons.verified, color: Colors.green.shade400),
                              onPressed: () {
                                // todo validate
                                print("ok${addPins(pins)} $verificationId");
                                if (otpkey.currentState!.validate()) {
                                  state.auth.verifyOTP(verifyID: verificationId, otp: addPins(pins), context: context);
                                }
                              },
                              label: const Text(
                                "Verify",
                                style: TextStyle(color: Colors.black),
                              ),
                              // shape: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  String addPins(List<TextEditingController> pins) {
    String pin = "";
    for (var element in pins) {
      pin += element.text;
    }
    return pin;
  }
}
