import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  FocusNode focusnode = FocusNode();

  TextEditingController pin1 = TextEditingController();

  TextEditingController pin2 = TextEditingController();

  TextEditingController pin3 = TextEditingController();

  TextEditingController pin4 = TextEditingController();

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
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
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
                        pin2.clear();
                        pin3.clear();
                        pin4.clear();
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
                  )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                      controller: pin2,
                      onTap: () {
                        pin2.clear();
                        pin3.clear();
                        pin4.clear();
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
                        pin4.clear();
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
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    print(pin1.text);
                    print(pin2.text);
                    print(pin3.text);
                    print(pin4.text);
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
