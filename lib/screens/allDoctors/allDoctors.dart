import 'dart:js';

import 'package:flutter/material.dart';

import '../../services/fire_store.dart';


class allDoctors extends StatefulWidget {
  const allDoctors({Key? key}) : super(key: key);

  @override
  State<allDoctors> createState() => _allDoctorsState();



}

class _allDoctorsState extends State<allDoctors> {
  get doctorCards => null;



  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    showDoctorCards();
  }
  void showDoctorCards() async{
    List<dynamic> doctorCards = await FirestoreService().getUsers();

    //log(users.length.toString());
    doctorCards.forEach((element) async {

      if(element['type'] == 'doctor')
      {

        doctorCards.add(
            Card(
              child: ListTile(
                title: Text(element['userName'] ?? ''),
                subtitle: Text(element['specialization'] ?? ''),
                onTap: () {
                  Navigator.pushNamed(context as BuildContext, '/userDetails', arguments: element);
                },
              ),
            ));
        // log(dataBytes.toString()  );


        //setState(() {});
      }

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Doctors'),
      ),
      body: ListView(
        children: [
          Column(
            children: doctorCards,
          ),
        ],
      ),
    );
  }
}


