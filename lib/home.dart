import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Completer<GoogleMapController> _con = Completer();

class _HomeScreenState extends State<HomeScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.00968, 71.79445),
    zoom: 14.4746,
  );
  List<Marker> _mark = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(34.00968, 71.79445),
        infoWindow: InfoWindow(title: "haris machinc")),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(33.6941, 72.9734),
        infoWindow: InfoWindow(title: "zain machinc "))
  ];

  @override
  void initState() {
    super.initState();
    _mark.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_mark),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _con.complete(controller);
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.location_disabled_outlined),
            onPressed: () async {
              GoogleMapController controller = await _con.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14)));

              setState(() {});
            }),
      ),
    );
  }
}
