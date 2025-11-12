import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_ex/views/add_voucher_code.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '/Controllers/cart_controller.dart';
import '/Controllers/checkout_controller.dart';
import '/Controllers/global-controller.dart';
import '/models/pay_stack.dart';
import '/models/razor_pay.dart';
import '/services/paystack_service.dart';
import '/services/razorpay_service.dart';
import '/services/validators.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '../Controllers/address_controller.dart';
import 'address/address_list.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var mainHeight, mainWidth;
  final _formKey = GlobalKey<FormState>();
  Validators validators = Validators();
  List<String>? paymentMethod = ["Cash on delivery", "Online payment"];
  List<String>? orderMethod = ["Delivery", "Pickup"];
  List<String> paymentOptions = ["Stripe", "RazorPay", "PayStack"];
  String dropdownValue = 'Stripe';
  String? addressName = '';
  String? addressLabel = '';
  double? addressLat;
  double? addressLong;
  int orderPaymentSelect = 0, orderTypeSelect = 0;
  String? city;
  String? latitude;
  String? longitude;
  bool isClicked = true;
  CheckoutController checkoutController = CheckoutController();
  TextEditingController phoneController = TextEditingController();
  final addressController = Get.put(AddressController());
  final settingController = Get.put(GlobalController());
  RazorPay? razorPay;
  RazorPayService? razorPayService;
  PayStack? payStack;
  PaystackService? payStackService;

  final Set<Marker> _markers = {};
  Completer<GoogleMapController> controller1 = Completer();
  late LatLng _lastMapPosition;

  final checkout = Get.put(CheckoutController());

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
    checkoutController.onInit();
    addressController.onInit();
    addressLabel = addressController.addressLabelName;
    addressName = addressController.addressName;
    addressLat = double.parse(addressController.addressLat.toString());
    addressLong = double.parse(addressController.addressLong.toString());
    final stripekey = settingController.stripeKey;
    Stripe.publishableKey = stripekey!;
    Stripe.instance.applySettings();
    _lastMapPosition = LatLng(
      double.parse(Get.find<AddressController>().addressLat),
      double.parse(Get.find<AddressController>().addressLong),
    );

    _markers.add(
      Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "YOU_ARE_HERE".tr,
          snippet: "THIS_IS_A_CURRENT_LOCATION_SNIPPET".tr,
          onTap: () {},
        ),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    _lastMapPosition = LatLng(
      double.parse(Get.find<AddressController>().addressLat),
      double.parse(Get.find<AddressController>().addressLong),
    );
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final cartController = Get.put(CartController());
    final stripesecret = settingController.stripeSecret;
    final currencyName = settingController.currencyName;
    final paystacKey = settingController.paystacKey;
    final razorpayKey = settingController.razorpayKey;
    final razorpaySecret = settingController.razorpaySecret;
    addressLabel = addressController.addressLabelName;
    addressName = addressController.addressName;
    addressLat = double.parse(addressController.addressLat.toString());
    addressLong = double.parse(addressController.addressLong.toString());

    return Scaffold(
      bottomNavigationBar: GetBuilder<CartController>(
        init: CartController(),
        builder:
            (cert) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              height: mainHeight / 3.5,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'SUB_TOTAL'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${Get.find<GlobalController>().currency!}" +
                                "${cert.totalCartValue}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 5,),
                  if (cartController.pickMethod == 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'DELIVERY_FEE'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${Get.find<GlobalController>().currency!}" +
                                  "${cert.distanceDeliveryCharge}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  //SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'DISCOUNT'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${Get.find<GlobalController>().currency!}" +
                                "${checkout.discount}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'TOTAL'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //changehere
                        cartController.pickMethod == 0
                            ? Container(
                              child: Text(
                                "${Get.find<GlobalController>().currency!}" +
                                    "${(cert.totalCartValue + cert.distanceDeliveryCharge - checkout.discount).toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                            : Container(
                              child: Text(
                                "${Get.find<GlobalController>().currency!}" +
                                    "${cert.totalCartValue - checkout.discount}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                      ],
                    ),
                  ), // SizedBox(height: 10,),
                  //proceed button
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: mainWidth,
                    height: 65,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ThemeColors.baseThemeColor, // background
                        foregroundColor: Colors.white, // foreground
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                      onPressed:
                          isClicked
                              ? () async {
                                setState(() {
                                  isClicked = false;
                                });

                                double total = 0.0;
                                if (cartController.pickMethod == 0) {
                                  total =
                                      cert.totalCartValue + cert.deliveryCharge;
                                } else {
                                  total = cert.totalCartValue;
                                }

                                if (orderPaymentSelect == 0) {
                                  checkoutController.postOrder(
                                    phoneController.text.trim(),
                                    false,
                                    '1',
                                    cartController.pickMethod,
                                    '5',
                                  );
                                } else if (orderPaymentSelect == 1) {
                                  switch (dropdownValue) {
                                    case "Stripe":
                                      await makePayment(
                                        stripesecret!,
                                        currencyName,
                                        total,
                                        checkoutController.name,
                                        cartController.pickMethod,
                                      );
                                      break;

                                    case "PayStack":
                                      PaystackService(
                                        context: context,
                                        payStackKey: paystacKey,
                                        email: checkoutController.email,
                                        phoneNumber: checkoutController.phone,
                                        address: checkoutController.address,
                                        latitude: latitude,
                                        longitude: longitude,
                                        orderTypeSelect:
                                            cartController.pickMethod,
                                        price: total.toInt(),
                                      ).chargeCardAndMakePayment();
                                      break;

                                    case "RazorPay":
                                      // calculateAmount(total.toString());
                                      razorPay = RazorPay(
                                        razorpaySecret: razorpaySecret,
                                        razorpayKey: razorpayKey,
                                        email: checkoutController.email,
                                        phone: checkoutController.phone,
                                        description:
                                            checkoutController.username,
                                        amount: total.toInt(),
                                        name: checkoutController.name,
                                        latitude: latitude,
                                        longitude: latitude,
                                        orderTypeSelect: orderTypeSelect,
                                        adress: '',
                                      );
                                      razorPayService = RazorPayService(
                                        razorPay,
                                      );
                                      razorPayService!.init();
                                      razorPayService!.openCheckout();

                                      break;
                                  }
                                }
                              }
                              : null,
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        title: Text('CHECKOUT_PAGE'.tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<CheckoutController>(
        init: CheckoutController(),
        builder:
            (checkout) => Container(
              height: mainHeight,
              width: mainWidth,
              color: Colors.white,
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller:
                              phoneController
                                ..text =
                                    checkout.phone == null
                                        ? ''
                                        : checkout.phone!
                                ..selection = TextSelection.collapsed(
                                  offset: phoneController.text.length,
                                ),
                          obscureText: false,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          cursorColor: ThemeColors.primaryColor,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              top: 0,
                              left: 15,
                            ),
                            fillColor: const Color(0xffF2CDD4),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: ThemeColors.primaryColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: ThemeColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: ThemeColors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xffF2CDD4),
                              ),
                            ),
                            hintText: 'ENTER_YOUR_PHONE_NUMBER'.tr,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ENTER_YOUR_PHONE_NUMBER'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      if (cartController.pickMethod == 0)
                        Container(
                          height: height * 0.25,
                          width: width * 0.99,
                          decoration: BoxDecoration(
                            color: Color(0Xfffdf1f5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.add_location,
                                    color: ThemeColors.baseThemeColor,
                                    size: 25,
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      'DELIVERY_ADDRESS'.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeColors.darkFont,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.36),
                                  InkWell(
                                    onTap: () async {
                                      String refresh = await Get.to(
                                        () => AddressList(),
                                      );
                                      setState(() {
                                        if (refresh == "refresh") {
                                          Get.find<AddressController>()
                                              .onInit();
                                          Get.find<CartController>().onInit();
                                        }
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.edit,
                                        color: ThemeColors.baseThemeColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => MapScreen(
                                  //               initialPosition:
                                  //                   const LatLng(23.7993487,
                                  //                       90.3627419),
                                  //             )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.02,
                                  ),
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
                                      zoom: 15.3746,
                                    ),
                                    onMapCreated: _onMapCreated,
                                    onCameraMove: _onCameraMove,
                                    myLocationEnabled: false,
                                    compassEnabled: true,
                                    myLocationButtonEnabled: false,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              addressLabel == 'current'
                                                  ? 'CURRENT_LOCATION.'.tr
                                                  : addressLabel.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0Xff3f3639),
                                                fontSize: width * 0.04,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.86,
                                            child: Text(
                                              addressName.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0Xffaaa4a6),
                                                fontSize: width * 0.032,
                                              ),
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20),
                      Text(
                        'PAYMENT_TYPE'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      _choosePaymentMedthod(),
                      SizedBox(height: 20),

                      //online payment type dropdown
                      (orderPaymentSelect == 1)
                          ?
                          //dropdown online payment type
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                              color: Color(0xFFF2F2F2),
                            ),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconEnabledColor: ThemeColors.baseThemeColor,
                                  items:
                                      paymentOptions
                                          .map<DropdownMenuItem<String>>((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      isClicked = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          )
                          : Container(),
                      SizedBox(height: 20),
                      //coupon
                      InkWell(
                        onTap: () {
                          Get.to(VoucherCodePage());
                        },
                        child: Text(
                          'ADD_VOUCHER_CODE'.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.baseThemeColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      //order summery
                      InkWell(
                        onTap: () {
                          //change
                        },
                        child: Text(
                          'ORDER_SUMMARY'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: cartController.cart.length,
                        itemBuilder: (context, itemIndex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                    imageUrl:
                                        cartController.cart[itemIndex].imgUrl!,
                                    imageBuilder:
                                        (ctx, imageProvider) => Container(
                                          height: mainWidth / 5,
                                          width: mainWidth / 5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                    placeholder:
                                        (context, url) => Shimmer.fromColors(
                                          child: Container(
                                            height: mainWidth / 5,
                                            width: mainWidth / 5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/farmhouse.jpg",
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[400]!,
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  ),
                                  title: Text(
                                    "${cartController.cart[itemIndex].name}",
                                    style: TextStyle(
                                      fontSize: FontSize.small2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${Get.find<GlobalController>().currencyCode!}${cartController.cart[itemIndex].price} x ${cartController.cart[itemIndex].qty} = ${Get.find<GlobalController>().currencyCode!}${cartController.cart[itemIndex].price! * cartController.cart[itemIndex].qty!}",
                                    style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: FontSize.small,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        "${Get.find<GlobalController>().currencyCode!}${cartController.cart[itemIndex].price! * cartController.cart[itemIndex].qty!}",
                                        style: TextStyle(
                                          fontSize: FontSize.medium,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      // Coupon code
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  _choosePaymentMedthod() => ToggleSwitch(
    minWidth: mainWidth / 2.5,
    cornerRadius: 20.0,
    activeBgColors: [
      [Colors.green],
      [ThemeColors.baseThemeColor],
    ],
    activeFgColor: Colors.white,
    inactiveBgColor: Colors.grey[300],
    inactiveFgColor: Colors.black,
    initialLabelIndex: orderPaymentSelect,
    totalSwitches: 2,
    labels: paymentMethod,
    radiusStyle: true,
    onToggle: (index) {
      setState(() {
        print(index);
        orderPaymentSelect = index!;
      });
      print('switched to: $index');
    },
  );

  Future<void> makePayment(
    stripeSecret,
    currency,
    total,
    customer,
    orderTypeSelect,
  ) async {
    try {
      paymentIntentData = await createPaymentIntent(
        stripeSecret,
        total.toString(),
        'usd',
      );
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // applePay: true,
              // googlePay: true,
              // testEnv: true,
              // style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: customer,
            ),
          )
          .then((value) {});
      displayPaymentSheet();
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((newValue) async {
            checkoutController.postOrder(
              phoneController.text.trim(),
              true,
              paymentIntentData!['id'].toString(),
              orderTypeSelect,
              '15',
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("PAID_SUCCESSFULLY".tr)));

            paymentIntentData = null;
          })
          .onError((error, stackTrace) {
            print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
          });
    } on StripeException {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("CANCELLED".tr)),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(stripeSecret, String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ' + stripeSecret,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    print(amount);
    final a = (double.parse(amount).toInt()) * 100;
    return a.toString();
  }
}
