import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: AppointmentForm(),
    );
  }
}

class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
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
    return Column(
      children: <Widget>[
        // ListTile(
        //   title: Text('Selected Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
        //   onTap: () => _selectDate(context),
        // ),
        // ListTile(
        //   title: Text('Selected Time: ${selectedTime.hour}:${selectedTime.minute}'),
        //   onTap: () => _selectTime(context),
        // ),
        ElevatedButton(
          onPressed: () {
            showConfirmationDialog(context);
          },
          child: Text('Book Appointment'),
        ),
      ],
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
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
              onPressed: () {
                // Handle booking appointment logic here
                // You can navigate back to the chat screen or any other screen after booking
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
