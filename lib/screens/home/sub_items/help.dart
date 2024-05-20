import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// class CustomerSupportScreen extends StatefulWidget {
//   @override
//   _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
// }
//
// class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   final _recipientController = TextEditingController(
//     text: 'ahmermalik099@gmail.com',
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Support'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value!.isEmpty || !value.contains('@')) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _messageController,
//                 decoration: InputDecoration(labelText: 'Message'),
//                 maxLines: 5,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your message';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   try{
//                     send();
//                   }
//                   catch(e){
//                     print(e);
//                   }
//
//                 },
//                 child: Text('Submit'),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Future<void> send() async {
//     final Email email = Email(
//       body: _messageController.text,
//       subject: _emailController.text,
//       recipients: _emailController.text.split(','),
//     );
//
//     String platformResponse;
//
//     try {
//       await FlutterEmailSender.send(email);
//       platformResponse = 'success';
//     } catch (error) {
//       print(error);
//       platformResponse = error.toString();
//     }
//
//     if (!mounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(platformResponse),
//       ),
//     );
//   }
//
// }
//
//
//






import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';



class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'ahmermalik099@gmail.com',
  );

  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please Enter the Subject',
                  labelText: 'Subject',
                ),
              ),
            ),
            SizedBox(
              height: 400.0,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Please Enter the Issue with your contact details',
                    ),
                  ),
                ),
              ),
            ),
            // CheckboxListTile(
            //   contentPadding:
            //   EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            //   title: Text('HTML'),
            //   onChanged: (bool? value) {
            //     if (value != null) {
            //       setState(() {
            //         isHTML = value;
            //       });
            //     }
            //   },
            //   value: isHTML,
            // ),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Column(
            //     children: <Widget>[
            //       for (var i = 0; i < attachments.length; i++)
            //         Row(
            //           children: <Widget>[
            //             Expanded(
            //               child: Text(
            //                 attachments[i],
            //                 softWrap: false,
            //                 overflow: TextOverflow.fade,
            //               ),
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.remove_circle),
            //               onPressed: () => {_removeAttachment(i)},
            //             )
            //           ],
            //         ),
            //       Align(
            //         alignment: Alignment.centerRight,
            //         child: IconButton(
            //           icon: Icon(Icons.attach_file),
            //           onPressed: _openImagePicker,
            //         ),
            //       ),
            //       TextButton(
            //         child: Text('Attach file in app documents directory'),
            //         onPressed: () => _attachFileFromAppDocumentsDirectoy(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = appDocumentDir.path + '/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }
}