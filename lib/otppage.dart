import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notesapp/homepage.dart';
import 'package:notesapp/redux/actions.dart';
import 'package:notesapp/redux/appstate.dart';
import 'package:notesapp/utils/auth/auth.dart';
import 'package:provider/provider.dart';

import 'backgroundtheme.dart';

class OTPPage extends StatelessWidget {
  final String verifyID;
  OTPPage({Key? key, required this.verifyID}) : super(key: key);

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
            top: (Offset(MediaQuery.of(context).size.width * 0.5, 0) -
                        Offset(MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.height * 0.3))
                    .distance -
                (MediaQuery.of(context).size.height * 0.1),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/password.gif",
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "OTP",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                //otp fields
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.transparent.withOpacity(0.07), borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.transparent, width: 1)),
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
                      )),
                    ],
                  ),
                ),

                //button for login
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.verified, color: Colors.black),
                  onPressed: () => Provider.of<Auth>(context, listen: false)
                      .verifyOTP(verifyID, "${pin1.text}${pin2.text}${pin3.text}${pin4.text}${pin5.text}${pin6.text}", context),
                  label: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.black),
                  ),
                  // shape: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
