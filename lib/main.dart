import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_canteen/Screens/uploadScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:night_canteen/Screens/userScreen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp( const Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( initialRoute: '/upload',
      routes: {
        '/upload': (context) => UploadScreen(),
        '/user': (context) => UserScreen(),
      }
    );

  }
}
