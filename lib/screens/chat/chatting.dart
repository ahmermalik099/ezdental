import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../services/fire_store.dart';
import 'appointment.dart';
import 'components/booking_msg.dart';
import 'components/msg.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {



  final TextEditingController messageController = TextEditingController();
  String chatId = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (chatId == '') {
      chatId = user['chatId'];
    }
    final String name = user['userName'];

    log(chatId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 140, 176),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  user['pfp_url'] ??
                      'https://images.immediate.co.uk/production/volatile/sites/3/2023/08/fdee6eacd43859584486e44228df60491637670269main-Cropped-8330369.jpg?resize=768,574',
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          //appointment function
          actions: [
          FutureBuilder<List<dynamic>>(
            future: FirestoreService().getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final users = snapshot.data!;
                final bool isDoctor = users.any((user) => user['type'] == 'doctor');
                if (isDoctor) {
                  return   ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Appointment'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Selected Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
                                    onTap: () => _selectDate(context),
                                  ),
                                  ListTile(
                                    title: Text('Selected Time: ${selectedTime.hour}:${selectedTime.minute}'),
                                    onTap: () => _selectTime(context),
                                  ),
                                  Text('Are you sure you want to book this appointment?'),
                                  Text('Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
                                  Text('Time: ${selectedTime.hour}:${selectedTime.minute}'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Confirm'),
                                onPressed: () async {
                                  await FirestoreService().updateChatsCollection(
                                      [user["uid"], FirebaseAuth.instance.currentUser!.uid],
                                      chatId,
                                      'Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}\nTime: ${selectedTime.hour}:${selectedTime.minute}','booking');
                                    await FirestoreService().createBooking(
                                      [user["uid"], FirebaseAuth.instance.currentUser!.uid],
                                      chatId,
                                      'Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}\nTime: ${selectedTime.hour}:${selectedTime.minute}',
                                    );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Book An Appointment'),
                    //icon: Icon(Icons.access_time_outlined),
                  );
                } else {
                  return SizedBox();
                }
              }
            },
          ),
        ]

      ),
      body: Column(
        children: [
          Container(
            height: height * 0.75,
            width: width,
            child: MessageStream(
              chatId: chatId,
              imgs: [
                FirebaseAuth.instance.currentUser!.photoURL ??
                    'https://www.animesenpai.net/wp-content/uploads/2023/08/dfdc2d53-d37f-425d-8e1a-2594e9505577-1024x513.jpg.webp',
                user['pfp_url'] ??
                    'https://images.immediate.co.uk/production/volatile/sites/3/2023/08/fdee6eacd43859584486e44228df60491637670269main-Cropped-8330369.jpg?resize=768,574'
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: IconButton(
                    onPressed: () {
                      print('+button pressed');
                      //  AppointmentForm();
                      print('after +button pressed');

                      //showConfirmationDialog(context);
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
                Container(
                  width: width * 0.6,
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                    ),
                  ),
                ),
                Container(
                  width: width * 0.2,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreService().updateChatsCollection(
                          [user["uid"], FirebaseAuth.instance.currentUser!.uid],
                          chatId,
                          messageController.text,'message');

                      messageController.clear();

                      if (user['chatId'] == '') {
                        String cId = await FirestoreService()
                            .checkIfBothChattersExist([
                          user["uid"],
                          FirebaseAuth.instance.currentUser!.uid
                        ]);
                        setState(() {
                          chatId = cId;
                        });
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key, required this.chatId, required this.imgs})
      : super(key: key);

  final String chatId;
  final List<String> imgs;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreService().getMessagesForChat(chatId),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final messagesDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: messagesDocs.length,
            itemBuilder: (context, index) {
              if(messagesDocs[index]['type'] == 'booking')
                return BookingMessage(
                  bookingMessage: messagesDocs[index]['message'],
                );
              return MyMessage(
                  isUser: messagesDocs[index]['created_by'] ==
                      FirebaseAuth.instance.currentUser!.uid,
                  msg: messagesDocs[index]['message'],
                  imgs: imgs);
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('No messages yet'),
          );
        }
      },
    );
  }
}






// SizedBox(
// height: 10,
// ),
// MyMessage(
// isUser: true,
// msg: "YOLOOOOOOo",
// ),
// SizedBox(
// height: 10,
// ),
// MyMessage(
// isUser: false,
// msg: "COooking maybe potentially probably",
// ),
