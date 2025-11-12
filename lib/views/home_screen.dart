import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ex/constants/constant.dart';
import 'package:food_ex/views/address/address_add.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '/Controllers/banner_controller.dart';
import '/Controllers/category_Controller.dart';
import '/Controllers/cuisine_controller.dart';
import '/Controllers/global-controller.dart';
import '/Controllers/popular_restaurant_controller.dart';
import '/utils/theme_colors.dart';
import '/views/no_restaurants_found.dart';
import '/views/restaurant_details.dart';
import '/views/view_restaurent_page_search.dart';
import '/widgets/all_restaurants_heading.dart';
import '/widgets/cuisine_heading.dart';
import '/widgets/custom_slider.dart';
import '/widgets/popular_cuisines.dart';
import '/widgets/shimmer/popular_restaurant_shimmer.dart';
import '../Controllers/address_controller.dart';
import 'map/map_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  String? token;
  late String deviceId;
  late LatLng latLng;
  String? addressName = '';
  String? currentAddressName;
  String? street;
  String? subCity;
  String? city;
  dynamic addressLabel = '';

  LocationData? currentLocation;

  final settingController = Get.put(GlobalController());
  final categoriesController = Get.put(CategoryController());
  final popularRestaurantsController = Get.put(PopularRestaurantController());
  final bannerController = Get.put(BannerController());
  final cuisinesController = Get.put(CuisineController());
  final addressController = Get.put(AddressController());

  Future<Null> _onRefresh() {
    setState(() {
      categoriesController.onInit();
      popularRestaurantsController.onInit();
      bannerController.onInit();
      cuisinesController.onInit();
      addressController.onInit();
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }

  var mainHeight, mainWidth;
  bool isSearching = false;

  String page = 'Home';

  @override
  void initState() {
    if (mounted) {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {});

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.data.isNotEmpty) {
          showOverlayNotification((context) {
            return Card(
              semanticContainer: true,
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: SafeArea(
                child: ListTile(
                  leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          'assets/images/icon.png',
                          height: 35,
                          width: 35,
                        )),
                  ),
                  title: Text(message.data['title'].toString()),
                  subtitle: Text(message.data['body'].toString()),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      }),
                ),
              ),
            );
          });
        }
      });
    }

    setInitialLocation();
    update();
    super.initState();
  }

  update() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    settingController.updateFCMToken(deviceToken);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('LOCATION_SERVICES_ARE_DISABLED'.tr);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('LOCATION_SERVICES_ARE_DENIED'.tr);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('LOCATION_PERMISSIONS_ARE_PERMANENTLY_DENIED'.tr);
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    var address;
    address = place.street;
    address = "$address, ${place.subLocality}";
    address = " $address  ${place.locality}";
    address = " $address  ${place.postalCode}";

    setState(() {
      addressLabel = addressController.addressLabelName;
      addressName = addressController.addressName;
      latLng = LatLng(position.latitude, position.longitude);
      this.street = place.street!;
      this.subCity = place.subLocality!;
      this.city = place.locality!;
      this.currentAddressName = address;
    });
    addressController.addCurrentAddress(
        address, position.latitude, position.longitude);
    addressController.onInit();
  }

  void setInitialLocation() async {
    Position position = await _getGeoLocationPosition();
    getAddressFromLatLong(position);
  }

  final _controller = SnappingSheetController();
  bool showMap = false;
  @override
  Widget build(BuildContext context) {
    addressLabel = addressController.addressLabelName;
    addressName = addressController.addressName;
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<PopularRestaurantController>(
        init: PopularRestaurantController(),
        builder: (popularRestaurant) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: ThemeColors.baseThemeColor,
              foregroundColor: Colors.white,
              centerTitle: false,
              title: GetBuilder<GlobalController>(
                  init: GlobalController(),
                  builder: (homeName) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: ScreenSize(context).mainWidth / 2.2,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (showMap) {
                                            showMap = false;
                                          } else {
                                            showMap = true;
                                          }
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressLabel == 'current'
                                                ? 'CURRENT_LOCATION.'.tr
                                                : addressLabel,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          addressName == null
                                              ? Text('')
                                              : Text(
                                                  addressName.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                        ],
                                      ))),
                              SizedBox(
                                width: ScreenSize(context).mainWidth / 2.2,
                                child: GestureDetector(
                                  onTap: () {
                                    settingController.userLogout();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.signOutAlt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
            ),
            backgroundColor: Colors.white,
            body: popularRestaurant.popularRestaurantLoader
                ? PopularRestaurantShimmer()
                : popularRestaurant.bestSellingRestaurantList.isEmpty
                    ? NoRestaurantFound()
                    : RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: SnappingSheet(
                          snappingPositions: const [
                            SnappingPosition.factor(
                                positionFactor: 0.445,
                                snappingCurve: Curves.easeInToLinear,
                                snappingDuration: Duration(milliseconds: 300)),
                            // SnapPosition(positionFactor: 0.6),
                          ],
                          sheetAbove: SnappingSheetContent(
                            child: showMap
                                ? Top_sheet_view(
                                    selection: addressLabel,
                                    currentAddress: currentAddressName,
                                    addresses: addressController.address,
                                    initialPosition: latLng,
                                    controller: _controller,
                                    callback: (value, address, lat, long) {
                                      setState(() {
                                        addressLabel = value;
                                        addressName = address;
                                        addressController.addAddress(
                                            value, address, lat, long);
                                        if (showMap) {
                                          showMap = false;
                                        } else {
                                          showMap = true;
                                        }
                                      });
                                    },
                                  )
                                : Container(),
                          ),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              color: Colors.white10,
                              //height: mainHeight,
                              child: Column(children: <Widget>[
                                Container(
                                  color: ThemeColors.baseThemeColor,
                                  padding: EdgeInsets.only(
                                      top: 0, right: 10, bottom: 10, left: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 14),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 5),
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          hintText:
                                              "SEARCHES_FOR_RESTAURANTS".tr,
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade500,
                                          ),
                                          suffixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        onTap: () {
                                          Get.to(ViewRestaurantPageSearch(
                                              type: activeMenu));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                bannerController.bannerList.isEmpty
                                    ? Container()
                                    : CustomSliderWidget(),
                                cuisinesController.cuisineList.isEmpty
                                    ? Container()
                                    : Divider(
                                        height: 10,
                                        thickness: 10,
                                      ),
                                cuisinesController.cuisineList.isEmpty
                                    ? Container()
                                    : CuisineHeading(),
                                cuisinesController.cuisineList.isEmpty
                                    ? Container()
                                    : Cuisines(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    height: 10,
                                    thickness: 10,
                                  ),
                                ),
                                AllRestaurantsHeading(),
                                popularRestaurant
                                        .bestSellingRestaurantList.isEmpty
                                    ? NoRestaurantFound()
                                    : Container(
                                        color: Colors.white10,
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: popularRestaurant
                                                .bestSellingRestaurantList
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5,
                                                    left: 10,
                                                    right: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(RestaurantDetails(
                                                      id: popularRestaurant
                                                          .bestSellingRestaurantList[
                                                              index]
                                                          .id,
                                                    ));
                                                  },
                                                  child: Card(
                                                    //shadowColor: Colors.grey,
                                                    elevation: 1,
                                                    // shadowColor: Colors.blueGrey,
                                                    margin: EdgeInsets.all(2),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2)),
                                                    ),
                                                    child: Column(
                                                      // crossAxisAlignment: CrossAxisAlignment.stretch,

                                                      children: <Widget>[
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              popularRestaurant
                                                                  .bestSellingRestaurantList[
                                                                      index]
                                                                  .image!,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 15),
                                                            height:
                                                                mainHeight / 4,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          2.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          2.0)),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit:
                                                                    BoxFit.fill,
                                                                //alignment: Alignment.topCenter,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer
                                                                  .fromColors(
                                                            child: Container(
                                                                height: 130,
                                                                width:
                                                                    mainWidth,
                                                                color: Colors
                                                                    .grey),
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[400]!,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      5.0),
                                                          child: ListTile(
                                                            //  leading:CircleAvatar(backgroundImage:AssetImage("assets/images/pizza_hut") ,) ,
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          5),
                                                              child: Text(
                                                                '${popularRestaurant.bestSellingRestaurantList[index].name}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),

                                                            subtitle: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${popularRestaurant.bestSellingRestaurantList[index].description}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "${popularRestaurant.bestSellingRestaurantList[index].address}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    RatingBar
                                                                        .builder(
                                                                      itemSize:
                                                                          20,
                                                                      initialRating: popularRestaurant
                                                                          .bestSellingRestaurantList[
                                                                              index]
                                                                          .avgRating!
                                                                          .toDouble(),
                                                                      minRating:
                                                                          1,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: ThemeColors
                                                                            .baseThemeColor,
                                                                      ),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        "(${popularRestaurant.bestSellingRestaurantList[index].avgRatingUser!.toInt()}) " +
                                                                            "REVIEWS".tr,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                              ]),
                            ),
                          ),
                        ),
                      )));
  }
}

enum selectadd { current, home, office }

// ignore: must_be_immutable
class Top_sheet_view extends StatefulWidget {
  LatLng initialPosition;
  dynamic addresses;
  dynamic selection;
  dynamic currentAddress;
  Function callback;
  SnappingSheetController controller;

  Top_sheet_view(
      {Key? key,
      required this.initialPosition,
      required this.addresses,
      required this.currentAddress,
      required this.callback,
      required this.controller,
      required this.selection})
      : super(key: key);

  @override
  _Top_sheet_viewState createState() => _Top_sheet_viewState();
}

class _Top_sheet_viewState extends State<Top_sheet_view> {
  dynamic addressLabel = '';
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
    addressLabel = widget.selection;
    _lastMapPosition = widget.initialPosition;
    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
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
    return Container(
        height: height * 0.445,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            )
          ],
        ),
        child: Stack(children: <Widget>[
          SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      top: height * 0.02,
                      left: width * 0.04,
                      right: width * 0.04),
                  height: height * 0.21,
                  width: width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0Xfffdf1f5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                        initialPosition: const LatLng(
                                            23.7993487, 90.3627419),
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: height * 0.02,
                              left: width * 0.02,
                              right: width * 0.02),
                          height: height * 0.12,
                          width: width * 0.99,
                          child: GoogleMap(
                            markers: _markers,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            mapType: _currentMapType,
                            initialCameraPosition: CameraPosition(
                              target: _lastMapPosition,
                              zoom: 16.4746,
                            ),
                            onMapCreated: _onMapCreated,
                            onCameraMove: _onCameraMove,
                            myLocationEnabled: false,
                            compassEnabled: true,
                            myLocationButtonEnabled: false,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Radio(
                                  value: 'current',
                                  activeColor: Colors.pink,
                                  focusColor: Colors.white,
                                  groupValue: addressLabel,
                                  onChanged: (value) {
                                    addressLabel = value!;
                                    widget.callback(
                                        addressLabel,
                                        widget.currentAddress,
                                        _lastMapPosition.latitude.toString(),
                                        _lastMapPosition.longitude.toString());
                                  },
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                addressLabel = 'current';
                                widget.callback(
                                    addressLabel,
                                    widget.currentAddress,
                                    _lastMapPosition.latitude.toString(),
                                    _lastMapPosition.longitude.toString());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'CURRENT_LOCATION'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0Xff3f3639),
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.6,
                                    child: Text(
                                      widget.currentAddress,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0Xffaaa4a6),
                                        fontSize: width * 0.032,
                                      ),
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.addresses.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: height * 0.01,
                            left: width * 0.04,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Radio(
                                    value: widget.addresses[index].labelName
                                        .toString(),
                                    activeColor: Colors.pink,
                                    focusColor: Colors.white,
                                    groupValue: addressLabel,
                                    onChanged: (value) {
                                      
                                      addressLabel = value!;
                                      widget.callback(
                                          addressLabel,
                                          widget.addresses[index].address,
                                          widget.addresses[index].lat,
                                          widget.addresses[index].long);
                                    },
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  addressLabel =
                                      widget.addresses[index].labelName;
                                  widget.callback(
                                      addressLabel,
                                      widget.addresses[index].address,
                                      widget.addresses[index].lat,
                                      widget.addresses[index].long);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.addresses[index].labelName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0Xff3f3639),
                                          fontSize: width * 0.04,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.82,
                                      child: Text(
                                        widget.addresses[index].address,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0Xffaaa4a6),
                                          fontSize: width * 0.032,
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })),
            ],
          )),
          Positioned(
              left: 30.0,
              bottom: 0.0,
              child: Container(
                width: width,
                height: 60.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  margin: EdgeInsets.only(
                    left: width * 0.14,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            apiKey: Get.find<GlobalController>()
                                .googleMapApiKey
                                .toString(), // Put YOUR OWN KEY here.
                            onPlacePicked: (result) {
                              
                              Navigator.of(context).pop();
                            },
                            selectedPlaceWidgetBuilder:
                                (_, selectedPlace, state, isSearchBarFocused) {
                              return isSearchBarFocused
                                  ? Container()
                                  // Use FloatingCard or just create your own Widget.
                                  : FloatingCard(
                                      bottomPosition:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      leftPosition:
                                          MediaQuery.of(context).size.width *
                                              0.025,
                                      rightPosition:
                                          MediaQuery.of(context).size.width *
                                              0.025,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      borderRadius: BorderRadius.circular(12.0),
                                      elevation: 4.0,
                                      color: Theme.of(context).cardColor,
                                      child: state == SearchingState.Searching
                                          ? _buildLoadingIndicator()
                                          : _buildSelectionDetails(
                                              context, selectedPlace!),
                                    );
                            },
                            searchingText: '',
                            initialPosition: _lastMapPosition,
                            usePinPointingSearch: true,
                            useCurrentLocation: false,
                            enableMapTypeButton: false,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Color(0Xffb8175b),
                              ),
                              onPressed: null),
                        ),
                        Container(
                          child: Text(
                            "ADD_NEW_ADDRESS".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0Xffb8175b),
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ]));
  }
}

Widget _buildLoadingIndicator() {
  return Container(
    height: 48,
    child: const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget _buildSelectionDetails(BuildContext context, PickResult result) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Text(
          result.formattedAddress!,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          child: Text(
            "SELECT_HERE".tr,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () {
            Get.to(AddressAddPage(
              address: result,
            ));
          },
        ),
      ],
    ),
  );
}
