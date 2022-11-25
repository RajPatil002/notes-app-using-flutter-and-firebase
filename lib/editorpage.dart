import 'package:flutter/material.dart';

main() => runApp(
  MaterialApp(home: EditorPage())
);

class EditorPage extends StatelessWidget {
  EditorPage({Key? key}) : super(key: key);
  TextEditingController message  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your Note',
            border: InputBorder.none
          ),
          style: const TextStyle(
            fontSize: 22
          ),
          autofocus: true,
          controller: message,
          keyboardType: TextInputType.multiline,
          maxLines: 55,
          onChanged: (message){
            if(message.isNotEmpty){
              // print(this.message.text);
              // TODO
            }
          },
        ),
      ),
    );
  }
}
