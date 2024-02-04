// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/fire_store.dart';



class UserDetailsScreen extends StatefulWidget {


  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {



  String? gender;
  String? img;
  Color _iconColorFav = Colors.black;
  Color _iconColorEww = Colors.black;
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    img = user["img"];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String chatId= await FirestoreService().checkIfBothChattersExist([user["uid"],FirebaseAuth.instance.currentUser!.uid]);
          user['chatId']=chatId;
          Navigator.pushNamed(context, '/chatting', arguments: user);
        },
        child: Icon(Icons.message),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.cyanAccent.shade700,

        title: Text(
          user["userName"] ?? '',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: img != null
                          ? NetworkImage(img!)
                          : AssetImage('assets/img5.jpg')
                      as ImageProvider,
                      radius: 80,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent.shade700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user["bio"] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent.shade700),
                    )
                    ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: SizedBox(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.cyanAccent.shade700,
                                  size: 30,
                                ),
                                Text(
                                  user['age'] ?? '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .cyanAccent.shade700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.cyanAccent.shade700,
                                  size: 30,
                                ),
                                Text(
                                 user['city'] ?? '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .cyanAccent.shade700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Expanded(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.male,
                                  color: Colors.cyanAccent.shade700,
                                  size: 30,
                                ),
                                Text(
                                  user['gender'] ?? '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .cyanAccent.shade700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
             // ProfileSlider(isEditing: _isEditing, images: ['assets/img5.jpg']),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _iconColorFav = Colors.cyan;
                        _iconColorEww = Colors.black;
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 40,
                    ),
                    color: _iconColorFav,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _iconColorEww = Colors.cyan;
                        _iconColorFav = Colors.black;
                      });
                    },
                    icon: Icon(
                      Icons.heart_broken_outlined,
                      size: 40,
                    ),
                    color: _iconColorEww,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

