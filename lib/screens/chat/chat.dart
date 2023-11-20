import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/fire_store.dart';
import 'components/chat_row.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> users = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    loading = true;
    try {
      users = await FirestoreService().getUsers();
    } catch (e) {
      log(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : // render this stream after fetching the user data
          StreamBuilder(
              stream: FirestoreService().getChatsForUser(),
              builder: (context, snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
                  } else if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text(
                        'No Chats. Your chat will appear here.'); // Display a message if there's no data.
                  } else {
                    // Display the data from Firestore in your UI.
                    //Map<String, dynamic> data = snapshot.data!.docs[0].data();
                    // Use the data to build your UI for each document.
                    final chatDocs = snapshot.data!.docs;
                    // String status = '';

                    return ListView.builder(
                      itemCount: chatDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            chatDocs[index].data() as Map<String, dynamic>;
                        List<dynamic> user = users.where((user) {
                          if (user['uid'] == data['chatters'][0] ||
                              user['uid'] == data['chatters'][1] &&
                                  user['uid'] !=
                                      FirebaseAuth.instance.currentUser!.uid) {
                            return true;
                          }
                          return false;
                        }).toList();

                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  List<dynamic> chatters = data['chatters'];
                                  log("chatters: ${chatters}");
                                  var otherUser = chatters
                                      .where((id) =>
                                          id !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .toList();
                                  log('${otherUser}');
                                  final user = await FirestoreService()
                                      .getUser(otherUser.first);
                                  // user is null
                                  print(user);
                                  final chatId = await FirestoreService()
                                      .checkIfBothChattersExist(chatters);
                                  user['chatId'] = chatId;
                                  Navigator.pushNamed(context, '/chatting',
                                      arguments: user);
                                },
                                child: ChatRow(
                                    message: data["last_message"],
                                    name: user[0]['userName'],
                                    img: user[0]['pfp_url'] ??
                                        'https://images.immediate.co.uk/production/volatile/sites/3/2023/08/fdee6eacd43859584486e44228df60491637670269main-Cropped-8330369.jpg?resize=768,574')),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  log(e.toString());
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
    );
  }
}
