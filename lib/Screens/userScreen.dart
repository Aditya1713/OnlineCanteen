import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_canteen/Screens/uploadScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:night_canteen/readData/ReadData.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  List<String> docId =[];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Items'),backgroundColor: Colors.grey[600],

          ),
          body: Container(
            color: Colors.grey[400],

            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  // border: Border(
                  //   top: BorderSide(width: 16.0), bottom: BorderSide(width: 16.0,),
                  // ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                           future:  getDocId(),
                          builder: (context,snapshot){
                            return ListView.builder(
                              itemCount: docId.length,

                              itemBuilder: (context,index){
                                return ListTile(
                                  title: ReadData(docId: docId[index],)
                                );
                              },
                            );
                          },
                        )

                      ),
                    ],
                  ),
                ),
              ),
            ),

          )
        ),
    );

  }
  Future getDocId() async{
    // WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseFirestore.instance.collection('Users').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
          docId.add(document.reference.id);
        }) );

  }

}
