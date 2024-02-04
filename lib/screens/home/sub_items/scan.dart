
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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
      Uri.parse("http://127.0.0.1:5000/"),
      body: base64,
      headers: requestHeaders,
    );
    print("after calling the API");

    print(response.body);
    setState(() {
      body = response.body;
    });
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
        Uri.parse('http://127.0.0.1:5000/'),
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
                }
            ),
          ],
        ),
      ),

    );
  }
}
