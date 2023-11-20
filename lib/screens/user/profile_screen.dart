// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/fire_store.dart';
import '../../services/storage.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  String? gender;
  String? img;
  Color _iconColorFav = Colors.black;
  Color _iconColorEww = Colors.black;
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.cyanAccent.shade700,
        actions: [
          _isEditing
              ? IconButton(
            onPressed: () {
              setState(() {
                _isEditing = false;
              });
              // firestore
              FirestoreService().mergeBio(bioController.text);
            },
            icon: Icon(
              Icons.check,
            ),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
        title: Text(
          FirebaseAuth.instance.currentUser!.email.toString() ??'username',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
        FirestoreService().getDetails(), // Replace with your actual stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // While waiting for data, display a loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            final data = snapshot.data!.data();
            userNameController.text = data?['userName'] ?? '';
            bioController.text = data?['bio'] ?? '';
            ageController.text = data?['age'] ?? '';
            cityController.text = data?['city'] ?? '';
            img = data?['pfp_url'] ?? '';
            String name = data?['name'] ?? 'User Name';
            String gender = data?['gender'] ?? ''; // Default gender
            List<dynamic> images =
                data?['images']  ?? []; // Default empty list

            log(data.toString());
            log(images.length.toString());
            // update the riverpod controller here
            return ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              img = (await StorageService().selectFile())!;
                              img == "" ? null : setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: img != null
                                  ? NetworkImage(img!)
                                  : AssetImage('assets/img5.jpg')
                              as ImageProvider,
                              radius: 80,
                            ),
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
                          userNameController.text ?? 'User Name',
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
                          child: TextField(
                            controller: bioController,
                            enabled: _isEditing ? true : false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'BIO',
                            ),
                            maxLines: null,
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: _isEditing
                          ? Colors.cyanAccent.shade700
                          : Colors.transparent,
                      child: !_isEditing
                          ? Column(
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
                                        data?['age'] ?? '',
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
                                        data?['city'] ?? '',
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
                                        gender,
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
                          : Center(
                        child: GestureDetector(
                          onTap: () {
                            // open dialog box
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MyModal(
                                    ageController: ageController,
                                    cityController: cityController,
                                    gender: gender);
                              },
                            );
                            // alert.(context);
                          },
                          child: Text(
                            'Tap to Edit',
                            style: TextStyle(
                                color: Colors.white, fontSize: 28),
                          ),
                        ),
                      ),
                    ),
                    // ProfileSlider(isEditing: _isEditing, images: images),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _iconColorFav = Colors.cyan;
                    //           _iconColorEww = Colors.black;
                    //         });
                    //       },
                    //       icon: Icon(
                    //         Icons.favorite,
                    //         size: 40,
                    //       ),
                    //       color: _iconColorFav,
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _iconColorEww = Colors.cyan;
                    //           _iconColorFav = Colors.black;
                    //         });
                    //       },
                    //       icon: Icon(
                    //         Icons.heart_broken_outlined,
                    //         size: 40,
                    //       ),
                    //       color: _iconColorEww,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AuthService().signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/checkScreen', (route) => false);
                        },
                        child: Text('Logout'))
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class MyModal extends StatefulWidget {
  MyModal({super.key, this.ageController, this.cityController, this.gender});

  final TextEditingController? ageController;
  final TextEditingController? cityController;
  String? gender;
  @override
  State<MyModal> createState() => _MyModalState();
}

class _MyModalState extends State<MyModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: widget.ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextFormField(
              controller: widget.cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            CheckboxListTile(
              title: Text('Male'),
              value: widget.gender == 'Male',
              onChanged: (newValue) {
                setState(() {
                  widget.gender = newValue != null ? 'Male' : null;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Female'),
              value: widget.gender == 'Female',
              onChanged: (newValue) {
                setState(() {
                  widget.gender = newValue != null ? 'Female' : null;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            FirestoreService().mergeDetails(widget.ageController!.text,
                widget.cityController!.text, widget.gender!);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
