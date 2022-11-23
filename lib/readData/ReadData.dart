
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadData extends StatelessWidget {

 final String docId;

  const ReadData({ required this.docId});

  @override
  Widget build(BuildContext context) {
    //get the collection reference
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    // DocumentReference reference = FirebaseFirestore.
    //                                      instance.collection("Users").doc("mlJqBsLtZduXD4oV3aQK");
    // reference.delete();
    String img1,img2,img3;
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(docId).get()
        ,builder: (
            (context , snapshot){

      if(snapshot.connectionState == ConnectionState.done){//data is loaded
        Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
         img1= data['img1'] ;
         img2= data['img2'] ;
         img3= data['img3'] ;
        return Container(
          padding: EdgeInsets.all(15),

         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(40),
           color: Colors.white,
         ),
          child: ListTile(
            
              title: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                       border: Border(top: BorderSide(width: 2.0,color: Colors.grey), bottom: BorderSide(width: 2.0,color: Colors.grey),left: BorderSide(width: 2.0,color: Colors.grey),right: BorderSide(width: 2.0,color: Colors.grey)
                       ),
                   borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(

                          child: Row(
                            children: [
                              Image.network(img1,height: 150,width: 300,),
                              Image.network(img2,height: 150,width: 300,),
                              Image.network(img3,height: 150,width: 300,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Item: ${data['ItemName']!}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Price: ${data['Price']!}",style: TextStyle(
                        fontWeight: FontWeight.bold,)
                          ,),
                      ),
                    ],
                  )
                ],
              )
          ),
        );
      }
      return Text('name is loading}');
    }
    )
    );
  }
}
