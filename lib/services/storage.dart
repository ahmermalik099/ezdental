import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as i;
// import 'firestore.dart';
import 'dart:developer' as d;
import 'package:uuid/uuid.dart';

import 'auth.dart';
import 'fire_store.dart';

class StorageService {
  PlatformFile? pickedFile;

  String? img;
  Future<String?> selectFile() async {
    try {
      d.log('selectfile function');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result == null) return "";

      pickedFile = result.files.first;

      final file = i.File(pickedFile!.path!);
      final path = 'pfp/${AuthService().user?.uid}';
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file); //upload to firebase storage

      img = await ref.getDownloadURL(); //retrieve that image's url
      d.log(img!);
      await AuthService().user?.updatePhotoURL(img!); // set users pfp
      await FirestoreService().addPFP(img!); // store in user document
      return img;
    } catch (e) {
      d.log(e.toString());
    }
    return "";
  }

  Future<List<String>> selectFiles() async {
    try {
      d.log('selectFiles function');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true, // Allow selecting multiple images
      );

      if (result == null) return [];

      List<String> imageUrls = [];

      for (var file in result.files) {
        final f = i.File(file.path!);
        final path =
            'showcase/${AuthService().user?.uid}/${Uuid().v4()}'; // Generate a unique path for each image
        final ref = FirebaseStorage.instance.ref().child(path);
        await ref.putFile(f); // Upload each image to Firebase Storage

        String imgUrl = await ref.getDownloadURL(); // Retrieve the image URL
        d.log(imgUrl);

        // Add the image URL to the list
        imageUrls.add(imgUrl);
      }

      FirestoreService().addShowcaseImages(imageUrls);

      return imageUrls;
    } catch (e) {
      d.log(e.toString());
      return [];
    }
  }
}
