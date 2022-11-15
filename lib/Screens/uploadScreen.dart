import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_canteen/Screens/uploadScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:night_canteen/Screens/userScreen.dart';
class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final textEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  XFile? file1, file2 , file3;
  List<File> imageList = [];
  // final List<BoxFit> bt =[BoxFit.fitWidth,BoxFit.fitHeight];
  List<String> urls = [];
  Future getImage(int n) async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

       if(image==null )return;
    //final imageTemp = File(image.path);
    setState((){
      if(n==1){
        this.file1 = image; imageList.add(File(file1!.path));
      }
      else if(n==2){
        this.file2 = image;
        imageList.add(File(file2!.path));
      }
      else{
        this.file3 = image;
        imageList.add(File(file3!.path));
      }
    });
  }
  Future<String> uploadFile(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef.child('pictures/${DateTime.now().millisecond}.jpeg');
    final uploadTask = ref.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    urls.add(url);
    return url;
  }

    @override
  void dispose() {
    priceEditingController.dispose();
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.grey[600],
          flexibleSpace: Align(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                child: Text("Upload",style:
                            TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.white),
                ),
              ),
            alignment: Alignment.centerLeft,
          ) ,
          title: Align(
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, '/user');
            }, icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.white,)),
          alignment: Alignment.centerRight,),
        ),
        body: Container(
          color: Colors.grey,

          child: Column(
            children: [
              Expanded(child: Row(
                 children: [
                   Expanded(child: Image(image: AssetImage("assets/images/pic1.jpg"),
                     fit: BoxFit.fill,
                   ),)
                 ],
              ),
                flex: 1,
              ),
               Expanded(flex: 3,
                 child:  Container(
                 decoration: BoxDecoration(
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                 ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          TextFormField(cursorColor: Colors.yellowAccent,
                            decoration: InputDecoration(
                              labelText: "Enter the item name",

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87, width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(),

                            ),
                            controller: textEditingController,
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Enter the price",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87, width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.all(Radius.circular(10))

                                ),
                                border: OutlineInputBorder()
                            ),controller: priceEditingController,
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 10,),
                              Container(height: 150,width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black87,width: 2),
                                  ),
                                  child: Expanded(
                                      child: file1!=null?Image.file(File(file1!.path),width: 100 ,height: 150): Icon(Icons.image_search_outlined))
                              ),
                              SizedBox(width: 10,),
                              Container(height: 150,width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black87,width: 2),
                                  ),
                                  child: Expanded(
                                      child: file2!=null?Image.file(File(file2!.path),width: 100 ,height: 150): Icon(Icons.image_search_outlined))
                              ),
                              SizedBox(width: 10,),
                              Container(height: 150,width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black87,width: 2),
                                  ),
                                  child: Expanded(
                                      child: file3!=null?Image.file(File(file3!.path),width: 100 ,height: 150): Icon(Icons.image_search_outlined))
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: IconButton(onPressed: () {getImage(1);},
                                    icon: Icon(Icons.add,color: Colors.black87)
                                ),
                              ),
                              Expanded(child: IconButton(onPressed: () {getImage(2);},
                                  icon: Icon(Icons.add,color: Colors.black87)
                              ),),
                              Expanded(
                                child: IconButton(onPressed: () {getImage(3);},
                                    icon: Icon(Icons.add,color: Colors.black87,)
                                ),
                              ),

                            ],
                          ),

                          ElevatedButton(
                            onPressed: () async{

                              for(int i=0;i<imageList.length;i++){
                                uploadFile(imageList[i]);

                              }
                              await FirebaseFirestore.instance.collection("Users").add({
                                "ItemName":textEditingController.text.trim(),
                                "Price":int.parse(priceEditingController.text.trim()),
                                "img1":urls[0],
                                "img2":urls[1],
                                "img3":urls[2],
                              });
                            }, child: Text("Upload"),

                          )
                        ],

                      ),
                    ),
                  ),

               ),
               )
            ],
          ),
        ),
      ),
    );
  }
}
