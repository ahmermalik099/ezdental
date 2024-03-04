
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';


class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  File? image;
  String? body;
  List<int>? imageBytes;



  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }


  Future<void> fetchHello() async {
    try {
      var dio = Dio();
      //var response = await http.get(Uri.parse('http://localhost:5000/hello'));
      http.Response response = await http.get(Uri.parse('http://127.0.0.1:5000/hello'));
      if (response.statusCode == 200) {
        print(response); // Output: "Hello, World!"
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  Future<void> pickImageC() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myfile == null) {
      // User canceled the image picking
      return;
    }

    image = File(myfile!.path!);
    imageBytes = image!.readAsBytesSync();
    if (image == null) {

      return;
    }

    String base64 = base64Encode(image!.readAsBytesSync());
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    print("before calling the API");
    http.Response response = await http.post(
      Uri.parse("https://ezdental.pythonanywhere.com/"),
      //Uri.parse("http://127.0.0.1:5000/"),
      body: base64,
      headers: requestHeaders,
    );
    print("after calling the API");

    print(response.body);
    setState(() {
      body = response.body;
    });
  }


  // Future<void> generateReport(BuildContext context) async {
  //   final patient = 'Patient Name';
  //   print('in gr');
  //   if (imageBytes == null) {
  //     // Handle the case where imageBytes is null
  //     return;
  //   }
  //
  //   await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async {
  //       final pdf = pw.Document();
  //
  //       pdf.addPage(
  //         pw.Page(
  //           build: (pw.Context context) {
  //             return pw.Column(
  //               children: [
  //                 pw.Row(
  //                   children: [
  //                     pw.Column(
  //                       mainAxisAlignment: pw.MainAxisAlignment.start,
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         // pw.Text("Name: ${patient.name}"),
  //                         // pw.Text("Email: ${patient.email}"),
  //                         // pw.Text("ID: ${patient.id}"),
  //                         // pw.Text("Phone Number: ${patient.phonenumber}"),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 pw.SizedBox(height: 20),
  //                 // Ensure imageBytes is not null before using it
  //                 pw.Image(pw.MemoryImage(Uint8List.fromList(imageBytes!))),
  //                 pw.SizedBox(height: 20),
  //                 pw.Center(child: pw.Text("Status : ${body ?? ""}",style: pw.TextStyle(fontSize: 20)))
  //               ],
  //             );
  //           },
  //         ),
  //       );
  //
  //       return pdf.save();
  //     },
  //   );
  // }

  //new generate report function



  Future<void> generateReport(BuildContext context) async {
    final patient = 'Patient Name';
    print('in gr');
    imageBytes = image!.readAsBytesSync();
    // if (imageBytes == null) {
    //   // Handle the case where imageBytes is null
    //   print('in null');
    //   return;
    // }

    // Find the temporary directory for storing files
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/report.pdf';
    print(filePath);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // pw.Text("Name: ${patient.name}"),
                      // pw.Text("Email: ${patient.email}"),
                      // pw.Text("ID: ${patient.id}"),
                      // pw.Text("Phone Number: ${patient.phonenumber}"),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              // Ensure imageBytes is not null before using it
              pw.Image(pw.MemoryImage(Uint8List.fromList(imageBytes!))),
              pw.SizedBox(height: 20),
              pw.Center(child: pw.Text("Status : ${body ?? ""}", style: pw.TextStyle(fontSize: 20)))
            ],
          );
        },
      ),
    );

    // Save the PDF to the file path
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Read the PDF as bytes
    final Uint8List pdfBytes = await file.readAsBytes();

    // Show a message to the user or handle the file as needed
    print('PDF saved to: $filePath');
  }



  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: SingleChildScrollView(
            child: Text('results here'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print("ahmer");
                generateReport(context);
              },
              child: Text('Report'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // imag from asssets

  Future<void> sendImageToServer() async {
    try {
      // Load the image from the assets folder
      ByteData data = await rootBundle.load('wc44.jpg');
      Uint8List imageBytes = data.buffer.asUint8List();

      // Create a multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://ezdental.pythonanywhere.com/"),

        // Uri.parse('http://127.0.0.1:5000/'),
      );

      // Add the image to the request as bytes
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'temp_image.jpg',
      ));

      // Send the request
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
        print('Image successfully uploaded to the server');

        // Convert the response data to JSON
        Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());

        // Print the JSON data
        print('Class: ${responseData['class']}');
        print('Confidence Score: ${responseData['confidence']}');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending image to server: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                    "Pick Image from Gallery",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  pickImage();
                }
            ),
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                    "Pick Image from Camera",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  sendImageToServer();
                  showReportDialog(context);
                }
            ),
          ],
        ),
      ),

    );
  }
}
