import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final String? uid;
  const HomePage({Key? key,required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30,top: 20,bottom: 20),
              child: Text("Welcome to Notes",style: TextStyle(fontSize: 30),),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users/$uid/Notes').snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> notes){
                  // print(notes.data?.docs[0].id +"");
                  if(notes.hasData){
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: notes.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime date = DateTime.parse("${notes.data?.docs[index].id.toString()}");
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          notes.data?.docs[index]["Title"],style: const TextStyle(fontSize: 23),overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FloatingActionButton(onPressed: (){},
                                          elevation: 20,
                                          backgroundColor: Colors.red,
                                          child: const Icon(Icons.delete_forever),
                                        ),
                                      )
                                    ],
                                  ),
                                  // const SizedBox(height: 20,),
                                  Expanded(flex: 3,child: Text(notes.data?.docs[index]["Message"]),),
                                  Row(
                                    children: [
                                      Expanded(flex: 4,child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(DateFormat("MMM dd yyyy").format(date),style: const TextStyle(fontSize: 15),),
                                          Text(DateFormat("HH:mm").format(date),style: const TextStyle(fontSize: 10),)
                                        ],
                                      ),),
                                      Expanded(
                                        flex: 2,
                                        child: FloatingActionButton(onPressed: (){},
                                          child: const Icon(Icons.edit),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
