import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezdental/services/fire_store.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late String patientNameUid;
  late String doctorNameUid ;
  late String patientName='';
  late String doctorName='';
  late String doctorNameResult='';


  @override
  void initState() {
    super.initState();
    //fetchNames();
  }


  // Future<void> fetchNames() async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> doctorSnapshot =
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(doctorNameUid)
  //         .get();
  //
  //     final DocumentSnapshot<Map<String, dynamic>> patientSnapshot =
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(patientNameUid)
  //         .get();
  //
  //     if (doctorSnapshot.exists && patientSnapshot.exists) {
  //       setState(() {
  //         doctorName = doctorSnapshot.data()?['userName'] ?? 'Doctor Name';
  //         patientName = patientSnapshot.data()?['userName'] ?? 'Patient Name';
  //       });
  //     } else {
  //       setState(() {
  //         doctorName = 'Doctor Name';
  //         patientName = 'Patient Name';
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching user data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getBookingForUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String,dynamic>> appointments = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return {
            'doctorPatientName': data['chatters'] ?? '',
            'dateTime': data['last_message'],          };
        }).toList();




        return Container(

          constraints: BoxConstraints.expand(),
          child: ListView.separated(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              patientNameUid=appointment['doctorPatientName'][0];
              doctorNameUid=appointment['doctorPatientName'][1];

              // FirebaseFirestore.instance.collection('users').doc(patientNameUid).get().then((value) {
              //   patientName=value['userName'];
              // });
              // FirebaseFirestore.instance.collection('users').doc(doctorNameUid).get().then((value) {
              //   doctorName=value['userName'];
              // });



              Future<void> fetchDoctorName(String doctorNameUid) async {
                try {
                  print('In try block');
                  final DocumentSnapshot<
                      Map<String, dynamic>> snapshot = await FirebaseFirestore
                      .instance.collection('users').doc(doctorNameUid).get();
                  if (snapshot.exists) {
                    setState(() {
                      doctorName = snapshot.data()?['userName'];
                    });
                    print(doctorName);
                  } else {
                    setState(() {
                      patientName = 'Patient Name';
                    });
                  }
                }
                  catch (e) {
                  // Error occurred while fetching data, handle this error
                  print('Error fetching user data: $e');
                }
              }
              Future<void> fetchPatientName(String doctorNameUid) async {
                try {

                  final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(patientNameUid).get();
                  if (snapshot.exists) {
                    setState(() {
                      patientName = snapshot.data()?['userName'];
                    });

                    print('patientName');
                    print(patientName);
                  } else {
                    setState(() {
                      patientName = 'Patient Name';
                    });
                  }
                } catch (e) {
                  // Error occurred while fetching data, handle this error
                  print('Error fetching user data: $e');
                }
              }


               fetchDoctorName(doctorNameUid);
               fetchPatientName(patientNameUid);
              print('appppppppppp\n\n\n\n');
              print(appointment);
              return Card (

                elevation: 4,
                margin: EdgeInsets.only(top: 8, left: 38, right: 38, bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [

                      Text('You Have An Appointment',style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8),
                      //Text('Patient: ${appointment['doctorPatientName'][0]}'),
                      Text('Patient: $patientName'),
                      const SizedBox(height: 8),
                      //Text('Doctor: ${appointment['doctorPatientName'][1]}\n'),
                      Text('Doctor: $doctorName\n'),
                      Text('${appointment['dateTime'].toString()}'),
                    ],
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
          ),
        );
      },
    );
  }
}

