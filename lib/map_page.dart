// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:clippy_flutter/triangle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class Mappage extends StatefulWidget {
  const Mappage({super.key});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  bool mapToggle = false;

  var currentLocation;

  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDPCI3LIzAdlphsFDC-6Q6T3Sgxs7sLAxk";
  // ignore: prefer_final_fields
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Future getMarkerData() async {
    FirebaseFirestore.instance.collection("locations").get().then((myMarkers) {
      if (myMarkers.docs.isNotEmpty) {
        for (int i = 0; i < myMarkers.docs.length; i++) {
          initMarker(myMarkers.docs[i].data(), myMarkers.docs[i].id);
        }
      }
    });
  }

  void initMarker(specify, specifyId) async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/m.png",
    );
    var markerIdVal = specifyId;

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        icon: markerbitmap,
        markerId: markerId,
        position:
            LatLng(specify['geopoint'].latitude, specify['geopoint'].longitude),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserProfileAvatar(
                                avatarUrl:
                                    'https://picsum.photos/id/237/5000/5000',
                                onAvatarTap: () {},
                                avatarSplashColor: Colors.purple,
                                radius: 40,
                                isActivityIndicatorSmall: false,
                                avatarBorderData: AvatarBorderData(
                                  borderColor: Colors.black54,
                                  borderWidth: 5.0,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                specify['description'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              )
                            ],
                          ),
                          ElevatedButton(
                            child: Text("check the store"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 0,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Color.fromARGB(255, 170, 217, 255),
                    width: 30.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            LatLng(specify['geopoint'].latitude, specify['geopoint'].longitude),
          );
        });
    setState(() {
      markers[markerId] = marker;
    });
  }

  void initState() {
    getMarkerData();
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: mapToggle
                  ? GoogleMap(
                      onTap: (position) {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: onMapCreated,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 14.0,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 200,
              offset: 50,
            )
          ],
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
      _customInfoWindowController.googleMapController = controller;
    });
  }
}
