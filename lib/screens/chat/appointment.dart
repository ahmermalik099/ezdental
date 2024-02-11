import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezdental/services/fire_store.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
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
              print('appppppppppp\n\n\n\n');
              print(appointment);
              return ListTile(
                title: Text('Patient: ${appointment['doctorPatientName'][0]}'),
                subtitle: Text('Doctor: ${appointment['doctorPatientName'][1]}\n'
                    'Date & Time: ${appointment['dateTime'].toString()}'),
              );
            }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
          ),
        );
      },
    );
  }
}

