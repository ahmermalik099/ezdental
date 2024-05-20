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
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(doctorNameUid).get();
      if (snapshot.exists) {
        doctorName = snapshot.data()?['userName'] ?? '';
        return doctorName;
      } else {
        patientName = 'Patient Name';
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
        return patientName;
      } else {
        patientName = 'Patient Name';
      }
    } catch (e) {
      // Error occurred while fetching data, handle this error
      print('Error fetching patient data: $e');
    }
    return "";
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await FirebaseFirestore.instance.collection('appointments').doc(appointmentId).delete();
      // Update UI after deleting appointment
      setState(() {});
    } catch (e) {
      print('Error deleting appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
            return {
              'id': doc.id,
              'doctorPatientName': data['chatters'] ?? '',
              'dateTime': data['last_message'],
            };
          }).toList();

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                image: AssetImage('assets/appointment.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                patientNameUid = appointment['doctorPatientName'][1];
                doctorNameUid = appointment['doctorPatientName'][0];

                fetchDoctorName(doctorNameUid);
                fetchPatientName(patientNameUid);

                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You Have An Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
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
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => deleteAppointment(appointment['id']),
                          child: Text('Cancel Appointment'),
                        ),
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
      ),
    );
  }
}
