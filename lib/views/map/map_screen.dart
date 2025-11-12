import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  LatLng initialPosition;

  MapScreen({Key? key, required this.initialPosition}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController searchController = new TextEditingController();
  GlobalKey iconKey = GlobalKey();
  final Set<Marker> _markers = {};
  Completer<GoogleMapController> controller1 = Completer();
  late LatLng _lastMapPosition;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    searchController.text = '14 Rd No 1, Dhaka1216, Bangladesh';
    _lastMapPosition = widget.initialPosition;
    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
        draggable: true,
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "YOU_ARE_HERE".tr,
            snippet: "THIS_IS_A_CURRENT_LOCATION_SNIPPET".tr,
            onTap: () {}),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 8),
          child: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0Xffb8175b)),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Container(
          padding: EdgeInsets.only(left: width * 0.03, right: width * 0.01),
          margin: EdgeInsets.only(
              right: width * 0.02, top: height * 0.01, bottom: height * 0.01),
          decoration: BoxDecoration(
              color: Color(0xfffaf6f7), borderRadius: BorderRadius.circular(9)),
          width: width * 0.98,
          child: Row(children: [
            Expanded(
              child: Container(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    hintText: 'SEARCH.'.tr,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  searchController.text = '';
                });
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.009),
                child: Icon(
                  Icons.highlight_off,
                  color: Color(0Xffb8175b),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _currentLocation();
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: width * 0.01, right: width * 0.009),
                child: Icon(
                  Icons.my_location,
                  color: Color(0Xffb8175b),
                ),
              ),
            )
          ]),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Stack(
            children: [
              /// Map Widget
              GoogleMap(
                markers: _markers,
                mapType: _currentMapType,
                initialCameraPosition: CameraPosition(
                  target: _lastMapPosition,
                  zoom: 14.4746,
                ),
                compassEnabled: true,
                rotateGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: true,
                onCameraMove: _onCameraMove,
                myLocationEnabled: false,
                // polylines: Polyline,
                myLocationButtonEnabled: false,
              ),

              Container(
                margin: EdgeInsets.only(
                  top: height * 0.78,
                  left: width * 0.04,
                  right: width * 0.04,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0Xffb8175b),
                        borderRadius: BorderRadiusDirectional.circular(8)),
                    child: Center(
                      child: Text(
                        "SEARCH".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await controller1.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
            widget.initialPosition.latitude, widget.initialPosition.longitude),
        zoom: 14.4746,
      ),
    ));
  }
}
