import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../services/fire_store.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late GoogleMapController mapController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareMarkers();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void prepareMarkers() async {
    // fetch all users from firebase

    List<dynamic> users = await FirestoreService().getUsers();
    log(users.length.toString());
    users.forEach((element) async {
      // add marker for each user

     // log(users.length.toString());

     // log(element.toString());

      if(element['type'] == 'doctor')
      {
        markerbitmap =
        await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 50)), 'assets/marker.png'
        );
        // log(dataBytes.toString()  );

        markers.add(Marker(
          //add start location marker
          markerId: MarkerId(element['userName'] ?? ''),
          position: LatLng(double.parse(element['lat'] ?? 33.7077),
              double.parse(element['long'] ?? 73.0498)), //posi\ion of marker
          infoWindow: InfoWindow(
            //popup info
              title: element['userName'] ?? '',
              snippet: 'Click for details',
              onTap: () {
                // static profile screen
                Navigator.pushNamed(context, '/userDetails', arguments: element);
              }),
          icon: markerbitmap, //Icon for Marker
        ));
        log(markers.length.toString()  );
        setState(() {});
      }


    });


  }

  late BitmapDescriptor markerbitmap;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: LatLng(33.7077, 73.0498), zoom: 12),
            myLocationEnabled: true,
            tiltGesturesEnabled: false,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              // Access the map controller here.
              mapController = controller;
            },
            markers: markers,
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: () async{
                    var currentZoomLevel = await mapController.getZoomLevel();

                    currentZoomLevel = currentZoomLevel + 1;
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(33.7077, 73.0498),
                          zoom: currentZoomLevel,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: () async{
                    var currentZoomLevel = await mapController.getZoomLevel();

                    currentZoomLevel = currentZoomLevel - 1;
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(33.7077, 73.0498),
                          zoom: currentZoomLevel,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Custom zoom buttons
