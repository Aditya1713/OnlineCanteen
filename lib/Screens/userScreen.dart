import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_canteen/Screens/uploadScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:night_canteen/items/chocoshake.dart';
import 'package:night_canteen/items/coffee.dart';
import 'package:night_canteen/items/orange.dart';
import 'package:night_canteen/items/strawberry.dart';
import 'package:night_canteen/items/tea.dart';
import 'package:night_canteen/readData/ReadData.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<String> items = [
    "Chocoshake",
    "Coffee",
    "Orange",
    "Strawberry",
    "Tea",
  ];

  /// List of body icon
  List<String> icons = [
    "assets/img/chocoshake.png",
    "assets/img/coffee.png",
    "assets/img/orangejuice.png",
    "assets/img/strawberry.png",
    "assets/img/tea.png",
  ];
  List<Widget> widgets = [
    ChocoShake(),
    Orange(),
    Coffee(),
    Tea(),
    Strawberry()
  ];
  int current = -1;



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(selectedItemColor: Colors.lightGreenAccent,
          items: [
            BottomNavigationBarItem(label:"",icon: Icon(Icons.warehouse,color: Colors.grey[700],)),
             BottomNavigationBarItem(label:"",icon: Icon(Icons.home_sharp,color: Colors.grey[700],)),
           BottomNavigationBarItem(label:"",icon: Icon(Icons.shopping_cart_sharp,color: Colors.grey[700],)),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,color: Colors.white,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(15),
                          child: CupertinoSearchTextField(backgroundColor: Colors.grey[200],)),

              SizedBox(
                width: double.infinity,
                  height: 400,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.white70
                                    : Colors.white54,
                                borderRadius: current == index
                                    ? BorderRadius.circular(15)
                                    : BorderRadius.circular(10),
                                border: current == index
                                    ? Border.all(
                                    color: Colors.green.withOpacity(1), width: 2)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  items[index],
                                  style: GoogleFonts.laila(
                                      fontWeight: FontWeight.w500,
                                      color: current == index
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              ),
                            ),
                          ),

                          Visibility(
                              visible: current == index,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              )),


                          GestureDetector(
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> widgets[index]));
                            },
                            child: AnimatedContainer(duration: Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.lightGreenAccent.withOpacity(0.4)
                                    : Colors.lightGreenAccent.withOpacity(0.4),
                                borderRadius: current == index
                                    ? BorderRadius.circular(15)
                                    : BorderRadius.circular(10),
                                border: current == index
                                    ? Border.all(
                                    color: Colors.green.withOpacity(1), width: 2)
                                    : null,
                              ),child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.asset(icons[index],height:90 ,width:80 ,),
                                  ),
                                  Text(items[index])
                                ],
                              ),
                            ),
                          ),
                          



                        ],
                      );
                    }),
              ),
           // Image.asset("assets/images/laptop.gif",height: 100,width: 50,)
            /* Container(
                margin: const EdgeInsets.only(top: 30),

                height: 550,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[current],
                      size: 200,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      items[current],
                      style: GoogleFonts.laila(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      );
  }
}