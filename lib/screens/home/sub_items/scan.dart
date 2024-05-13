
import 'dart:developer';
import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';


class YoloImageV8 extends StatefulWidget {
  FlutterVision vision = FlutterVision();
  YoloImageV8({
    Key? key,
  }) : super(key: key);

  @override
  State<YoloImageV8> createState() => _YoloImageV8State();
}

class _YoloImageV8State extends State<YoloImageV8> {
  late List<Map<String, dynamic>> yoloResults;
  File? imageFile;
  int imageHeight = 1;
  int imageWidth = 1;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    loadYoloModel().then((value) {
      setState(() {
        yoloResults = [];
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        imageFile != null ? Image.file(imageFile!) : const SizedBox(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: pickImage,
                child: const Text("Pick an image"),
              ),
              ElevatedButton(
                onPressed: yoloOnImage,
                child: const Text("Detect"),
              ),
              // ElevatedButton(
              //   onPressed: saveImageWithBoxes,
              //   child: const Text("Save Image"),
              // ),
            ],
          ),
        ),
        displayBoxesAroundRecognizedObjects(size),
      ],
    );
  }

  Future<void> loadYoloModel() async {
    log("before loading model");
    await widget.vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/best.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 2,
        useGpu: true);
    log("after loading model");

    setState(() {
      isLoaded = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
    }
  }

  yoloOnImage() async {
    print(yoloResults.length);
    yoloResults.clear();
    Uint8List byte = await imageFile!.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight = image.height;
    imageWidth = image.width;
    print("before sening to yolo on image");
    print(image);
    final result = await widget.vision.yoloOnImage(
        bytesList: byte,
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.6,
        confThreshold: 0.6,
        classThreshold: 0.6);
    print(result.length);
    if (result.isNotEmpty) {
      print("inside yolo on image");

      setState(() {
        yoloResults = result;
      });
      //saveImageWithBoxes();
    }
  }
  Widget displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return SizedBox();

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);
    var result = yoloResults[0];
    String tag = result["tag"];
    print(tag);

    if (tag.contains('healthy')) {
      print("healthy");
      colorPick = const Color.fromARGB(255, 50, 233, 30);
      tag = "defected";

    } else {
      print("defected");
      colorPick = const Color.fromARGB(255, 233, 50, 30);
      tag = "healthy";

    }
    print(result);
    return Positioned(
      left: result["box"][0] * factorX,
      top: result["box"][1] * factorY + pady,
      width: (result["box"][2] - result["box"][0]) * factorX,
      height: (result["box"][3] - result["box"][1]) * factorY,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.pink, width: 2.0),
        ),
        child: Text(
          "${tag} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
          style: TextStyle(
            background: Paint()..color = colorPick,
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );


    // return yoloResults.map((result) {
    //   print(result);
    //
    //   return Positioned(
    //     left: result["box"][0] * factorX,
    //     top: result["box"][1] * factorY + pady,
    //     width: (result["box"][2] - result["box"][0]) * factorX,
    //     height: (result["box"][3] - result["box"][1]) * factorY,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //         border: Border.all(color: Colors.pink, width: 2.0),
    //       ),
    //       child: Text(
    //         "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
    //         style: TextStyle(
    //           background: Paint()..color = colorPick,
    //           color: Colors.white,
    //           fontSize: 18.0,
    //         ),
    //       ),
    //     ),
    //   );
    // }).toList();
  }

  // Future<void> saveImageWithBoxes() async {
  //   print("in _save image with boxes");
  //   print(imageFile);
  //   print(yoloResults);
  //   if (imageFile != null && yoloResults.isNotEmpty) {
  //     await _saveImageWithBoxes(imageFile!);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Image saved with boxes'),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('No image or boxes to save'),
  //       ),
  //     );
  //   }
  // }

  // Future<void> _saveImageWithBoxes(File imageF) async {
  //   print("in _save image with boxes");
  //   try{
  //     Uint8List byte = await imageFile!.readAsBytes();
  //     final image = await decodeImageFromList(byte);
  //     final ByteData? data = await rootBundle.load('assets/labels.txt'); // You can replace 'assets/labels.txt' with any asset path if needed
  //     final Uint8List bytes = data!.buffer.asUint8List();
  //     final List<Map<String, dynamic>> result = List.from(yoloResults);
  //
  //     // Draw boxes on the image
  //     final ui.PictureRecorder recorder = ui.PictureRecorder();
  //     final Canvas canvas = Canvas(recorder);
  //     final paint = Paint()..isAntiAlias = true;
  //     canvas.drawImage(ui.Image.memory(byte), Offset.zero, paint);
  //
  //     // Convert Flutter image to byte data
  //     final ui.Image img = await recorder.endRecording().toImage(image.width, image.height);
  //     final ByteData? imgByteData = await img.toByteData(format: ui.ImageByteFormat.png);
  //     final Uint8List imgBytes = imgByteData!.buffer.asUint8List();
  //
  //     // Save image with boxes to the gallery
  //     await GallerySaver.saveImage(imgBytes, albumName: 'YourAlbumName'); // Replace 'YourAlbumName' with the desired album name
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }

}


