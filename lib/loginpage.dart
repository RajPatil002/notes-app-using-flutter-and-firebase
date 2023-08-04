import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/otppage.dart';
import 'package:notesapp/utils/auth/auth.dart';
import 'package:provider/provider.dart';

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

  // List<BorderSide> borders = List.generate(6, (index) => BorderSide.none);

  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
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
            // Positioned(
            //   top: (Offset(MediaQuery.of(context).size.width * 0.5, 0) -
            //               Offset(MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.height * 0.3))
            //           .distance -
            //       (MediaQuery.of(context).size.height * 0.1),
            //   // - (MediaQuery.of(context).size.height * 0.3),
            //   child: ClipRRect(
            //       borderRadius: BorderRadius.circular(100),
            //       child: Image.asset(
            //         "assets/verify.gif",
            //         height: MediaQuery.of(context).size.height * 0.2,
            //         width: MediaQuery.of(context).size.height * 0.2,
            //       )),
            // ),
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
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(30), gapPadding: 20, borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), gapPadding: 20, borderSide: BorderSide(color: valid, width: 3)),
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
                                    if (index < pins.length) {
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
                                        if (!phonekey.currentState!.validate()) {
                                          setState(() {
                                            isclicked = true;
                                          });

                                          await auth
                                              .requestOTP("+918806643372"
                                                  // phone.text.contains("+91") ? phone.text : '+91${phone.text}', todo enable
                                                  )
                                              .then((id) {
                                            print("aaaaaaaaaaaaa$id");
                                            if (id != null) {
                                              verificationId = id;
                                              setState(() {
                                                isclicked = false;
                                              });
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
                          backgroundColor: Colors.white,
                          icon: Icon(Icons.verified, color: Colors.green.shade400),
                          onPressed: () {
                            // todo validate
                            if (otpkey.currentState!.validate()) {
                              print("ok${addPins(pins)}");
                              auth.verifyOTP(verificationId, addPins(pins), context);
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
      ),
    );
  }

  String addPins(List<TextEditingController> pins) {
    String pin = "";
    for (var element in pins) {
      pin += element.text;
    }
    return pin;
  }
}
