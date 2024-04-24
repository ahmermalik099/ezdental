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
  late String doctorNameUid;
  late String patientName = '';
  late String doctorName = '';
  late String doctorNameResult = '';

  @override
  void initState() {
    super.initState();
    //fetchNames();
  }

  Future<String> fetchDoctorName(String doctorNameUid) async {
    try {
      print('In try block');
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(doctorNameUid).get();
      if (snapshot.exists) {
        doctorName = snapshot.data()?['userName'] ?? '';

        // setState(() {
        //   doctorName = snapshot.data()?['userName'] ?? '';
        // });
        return (doctorName);
      } else {
        patientName = 'Patient Name';
        // setState(() {
        //   patientName = 'Patient Name';
        // });
      }
    } catch (e) {
      // Error occurred while fetching data, handle this error
      print('Error fetching doctor data: $e');
    }
    return "";
  }

  Future<String> fetchPatientName(String patientNameUid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(patientNameUid).get();
      if (snapshot.exists) {
        patientName = snapshot.data()?['userName'] ?? '';
        // setState(() {
        //   patientName = snapshot.data()?['userName'] ?? '';
        // });
        return(patientName);
      } else {
        patientName = 'Patient Name';
        // setState(() {
        //   patientName = 'Patient Name';
        // });
      }
    } catch (e) {
      // Error occurred while fetching data, handle this error
      print('Error fetching patient data: $e');
    }
    return"";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getBookingForUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> appointments = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          print(data.toString());
          return {
            'doctorPatientName': data['chatters'] ?? '',
            'dateTime': data['last_message'],
          };
        }).toList();

        return Container(
          constraints: BoxConstraints.expand(),
          child: ListView.separated(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              patientNameUid = appointment['doctorPatientName'][0];
              doctorNameUid = appointment['doctorPatientName'][1];

              fetchDoctorName(doctorNameUid);
              fetchPatientName(patientNameUid);

              print(appointment);
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(top: 8, left: 38, right: 38, bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('You Have An Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Patient: $patientName'),
                      FutureBuilder(
                        future: fetchDoctorName(doctorNameUid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text('Doctor: $doctorName');
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('Doctor: $doctorName\n'),
                      FutureBuilder(
                        future: fetchPatientName(patientNameUid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text('Patient: $patientName');
                        },
                      ),
                      Text('${appointment['dateTime'].toString()}'),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        );
      },
    );
  }
}
