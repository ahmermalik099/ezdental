import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

class FirestoreService {
  // create a document for the user
  Future<void> createUser(String email, String lat, String long,
      String userName, String type) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'lat': lat,
      'long': long,
      'userName': userName,
      'type': type,
    });
  }

  Future<void> createAppointment(String email, String doctor, String patient,
      DateTime dateTime) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('appointments')
        .doc(uid)
        .set({
      'email': email,
      'doctor': doctor,
      'patient': patient,
      'dateTime': dateTime,
    });
  }

  // Future<String?> getUserType(String email) async {
  //   try {
  //     // Reference to the "users" collection
  //     CollectionReference users = FirebaseFirestore.instance.collection('users');
  //
  //     // Query for the document with the specified email
  //     QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
  //
  //     // Check if a document was found
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Get the first document (there should be only one matching document)
  //       DocumentSnapshot userDocument = querySnapshot.docs.first;
  //
  //       // Get the value of the "type" field
  //       String? userType = userDocument['type'];
  //
  //       // Return the user type
  //       return userType;
  //     } else {
  //       // If no document was found, return null or an appropriate value
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle any errors that occurred during the process
  //     print('Error: $e');
  //     return null;
  //   }
  // }


  //merge bio
  Future<void> mergeBio(String bio) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'bio': bio,
    }, SetOptions(merge: true));
  }

  Future<void> mergeDetails(String age, String city, String gender) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'age': age,
      'city': city,
      'gender': gender,
    }, SetOptions(merge: true));
  }

  Future<void> addPFP(String img) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseFirestore.instance.doc("users/${uid}");
    var data = {
      "pfp_url": img,
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> addShowcaseImages(List<String> img) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseFirestore.instance.doc("users/${uid}");
    var data = {
      "images": img,
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDetails() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Future<List<dynamic>> getUsers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'users').get();

    List<Map<String, dynamic>> usersList = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      userData['uid'] = doc.id; // Add the UID to the map
      usersList.add(userData);
    });

    return usersList;
  }

  Future<List<dynamic>> getPatients() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'patients').get();

    List<Map<String, dynamic>> patientsList = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> patientsData = doc.data() as Map<String, dynamic>;
      patientsData['uid'] = doc.id; // Add the UID to the map
      patientsList.add(patientsData);
    });

    return patientsList;
  }

  Future<Map<String, dynamic>> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users').doc(uid).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<
          String,
          dynamic>;
      userData['uid'] = documentSnapshot.id; // Add the UID to the map
      return userData;
    } else {
      // Handle the case where the user with the given UID doesn't exist
      return {};
    }
  }


  Future<void> updateChatsCollection(List<String> chatters,
      String chatId,
      String lastMessage,
      String type,) async {
    try {
      // Get a reference to the "chats" collection
      final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

      if (chatId.isEmpty) {
        // If chatId is empty, create a new document and save it to the variable
        final DocumentReference newChatDoc = await chatsCollection.add(
            {'chatters': chatters});
        chatId = newChatDoc.id;
      }

      log('$chatters');
      log('$chatters.runtimeType');
      log(chatId);
      // log('$runtimeType.runtimeType');
      log(lastMessage);
      log('$lastMessage.runtimeType');
      // Update the "chats" collectionnew msg
      final Map<String, dynamic> chatsData = {
        'chatters': chatters,
        'chat_id': chatId,
        'last_update': FieldValue.serverTimestamp(),
        'last_message': lastMessage,
        'type': type,
      };
      chatsCollection.doc(chatId).set(chatsData, SetOptions(merge: true));
      addMessageToChat(
          chatId, FirebaseAuth.instance.currentUser!.uid, lastMessage, type);

      // "chats" collection updated successfully
      log('Chats collection updated successfully');
    } catch (e) {
      // Handle any errors
      print('Error updating chats collection:$e');
    }
  }


  Future<void> addMessageToChat(String chatId,
      String createdBy,
      String message,
      String type,) async {
    try {
      // Get a reference to the chat document
      final DocumentReference chatDocRef =
      FirebaseFirestore.instance.collection('chats').doc(chatId);

      // Add a new message document to the "messages" subcollection
      final CollectionReference messagesCollection = chatDocRef.collection(
          'messages');

      final Map<String, dynamic> messageData = {
        'created_by': createdBy, // Logged-in user's UID
        'message': message,
        'created_at': FieldValue.serverTimestamp(), // Current date and time
        'type': type,
      };

      await messagesCollection.add(messageData);

      // Message added to the subcollection successfully
      print('Message added to the subcollection "messages"');
    } catch (e) {
      // Handle any errors
      print('Error adding message to subcollection: $e');
    }
  }


  Stream<QuerySnapshot<Object?>> getChatsForUser() {
    try {
      // Get a reference to the "chats" collection
      final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

      // Query the "chats" collection to find documents where the "chatters" array contains the user's UID
      var querySnapshot = chatsCollection
          .where(
          'chatters', arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('last_update', descending: false)
          .snapshots();

      // Return the list of chat documents
      return querySnapshot;
    } catch (e) {
      // Handle any errors
      print('Error fetching chat documents: $e');
      return Stream.empty();
    }
  }


  Stream<QuerySnapshot<Object?>> getMessagesForChat(String chatId) {
    try {
      // Get a reference to the chat document
      final DocumentReference chatDocRef =
      FirebaseFirestore.instance.collection('chats').doc(chatId);

      // Get a reference to the "messages" subcollection within the chat document
      final CollectionReference messagesCollection =
      chatDocRef.collection('messages');

      // Query the "messages" subcollection to get all documents
      final querySnapshot = messagesCollection.orderBy(
          'created_at', descending: false).snapshots();

      // Return the list of message documents
      return querySnapshot;
    } catch (e) {
      // Handle any errors
      print('Error fetching message documents: $e');
      return Stream.empty();
    }
  }


  Future<String> checkIfBothChattersExist(List<dynamic> uids) async {
    try {
      // Get a reference to the "chats" collection
      final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

      // Query the "chats" collection to find documents where the "chatters" field contains any of the specified UIDs
      final QuerySnapshot querySnapshot = await chatsCollection
          .where('chatters', arrayContainsAny: uids)
          .get();

      // Iterate through the chat documents
      for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
        final List<dynamic>? chatters = doc['chatters'];

        // Check if both UIDs exist in the "chatters" array
        if (chatters != null && chatters.contains(uids[0]) &&
            chatters.contains(uids[1])) {
          return doc.id; // Both UIDs exist in this chat document
        }
      }

      // Both UIDs were not found in any chat document
      return '';
    } catch (e) {
      // Handle any errors
      print('Error checking if both chatters exist: $e');
      return ''; // An error occurred
    }
  }


  Future<void> createBooking(List<String> chatters,
      List<String> chattersEmail,
      String chatId,
      String lastMessage,) async {
    try {
      // Get a reference to the "chats" collection
      final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

      if (chatId.isEmpty) {
        // If chatId is empty, create a new document and save it to the variable
        final DocumentReference newChatDoc = await appointmentsCollection.add(
            {'chatters': chatters});
        chatId = newChatDoc.id;
      }

      log('$chatters');
      log('$chatters.runtimeType');
      log(chatId);
      // log('$runtimeType.runtimeType');
      log(lastMessage);
      log('$lastMessage.runtimeType');
      // Update the "chats" collectionnew msg
      final Map<String, dynamic> chatsData = {
        'chatters': chatters,
        'chatters_email': chattersEmail,
        'chat_id': chatId,
        'last_update': FieldValue.serverTimestamp(),
        'last_message': lastMessage,
      };
      appointmentsCollection.doc(chatId).set(
          chatsData, SetOptions(merge: true));


      // "chats" collection updated successfully
      log('Chats collection updated successfully');
    } catch (e) {
      // Handle any errors
      print('Error updating chats collection: $e');
    }
  }


  Stream<QuerySnapshot<Object?>> getBookingForUser() {
    try {
      // Get a reference to the "chats" collection
      final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

      // Query the "chats" collection to find documents where the "chatters" array contains the user's UID
      var querySnapshot = appointmentsCollection
          .where(
          'chatters', arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('last_update', descending: false)
          .snapshots();

      // Return the list of chat documents
      return querySnapshot;
    } catch (e) {
      // Handle any errors
      print('Error fetching chat documents: $e');
      return Stream.empty();
    }
  }
}