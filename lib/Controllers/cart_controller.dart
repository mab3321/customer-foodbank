import 'dart:math';

import 'package:food_ex/models/restaurant_details.dart';

import '/models/cart_model.dart';
import 'package:get/get.dart';

import 'address_controller.dart';

class CartController extends GetxController {
  List<OrderMenuItem> cart = [];
  List<String> orderTypeLabel = ['Delivery', 'Pickup'];
  double totalCartValue = 0;
  int totalQunty = 0;
  double deliveryCharge = 0;
  double distanceDeliveryCharge = 0;
  double freeradius = 0;
  double chargePerKilo = 0;
  double lat = 0.0;
  double long = 0.0;
  String restaurantID = '';
  double kilometer = 0.0;
  int get total => cart.length;
  double? get charge => deliveryCharge;
  String get restaurantId => restaurantID;
  int pickMethodIndex = 0;
  int pickMethod = 0;
  int totalSwitches = 0;
  int deliveryStatus = 0;
  int pickupStatus = 0;

  @override
  void onInit() async {
    calculateTotal();

    super.onInit();
  }

  void pickedAddress() {
    lat = double.parse(Get.find<AddressController>().addressLat);
    long = double.parse(Get.find<AddressController>().addressLat);
  }

  void addProduct(menuItem, menuItemId, menuItemPrice, instructions, qunty,
      restaurantid, deliverycharge, selecteOptions, selectVaration) {
    restaurantID = restaurantid.toString();
    int index = cart.indexWhere((i) => i.id == menuItemId);
    if (index != -1)
      updateProduct(menuItemId, menuItemPrice, (cart[index].qty! + qunty));
    else {
      cart.add(OrderMenuItem(
          id: menuItemId,
          instructions: instructions.toString(),
          name: menuItem.menuItemName,
          price: double.parse(menuItemPrice),
          stockCount: 0,
          qty: qunty,
          imgUrl: menuItem.menuItemImage,
          variationId: selectVaration.toString(),
          options: selecteOptions));
      calculateTotal();
      update();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.id == product);
    calculateTotal();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  void updateProduct(productId, price, qty) {
    int index = cart.indexWhere((i) => i.id == productId);
    cart[index].qty = qty;
    cart[index].price = double.parse(price);
    if (cart[index].qty == 0) removeProduct(productId);
    calculateTotal();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    deliveryCharge = 0;
    totalQunty = 0;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  void calculateTotal() {
    totalCartValue = 0;
    totalQunty = 0;
    cart.forEach((f) {
      totalCartValue += (f.price!) * f.qty!;
      totalQunty += f.qty!;
    });
    calculateDistance(
        lat,
        long,
        double.parse(
          Get.find<AddressController>().addressLat,
        ),
        double.parse(
          Get.find<AddressController>().addressLong,
        ));
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  void addRestuarentData(Restaurant restaurantData) {
    deliveryCharge = double.parse(restaurantData.deliveryCharge.toString());
    freeradius = double.parse(restaurantData.freeDeliveryRadius.toString());
    chargePerKilo = double.parse(restaurantData.chargePerKilo.toString());
    deliveryStatus = restaurantData.deliveryStatus!;
    pickupStatus = restaurantData.pickupStatus!;
    lat = double.parse(restaurantData.lat.toString());
    long = double.parse(restaurantData.long.toString());
    orderType();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  orderType() {
    if (deliveryStatus == 5 && pickupStatus == 5) {
      totalSwitches = 2;
    } else if (deliveryStatus == 5) {
      orderTypeLabel = ['Delivery'];
      pickMethod = 0;
      totalSwitches = 1;
    } else if (pickupStatus == 5) {
      orderTypeLabel = ['Pickup'];
      pickMethod = 1;
      totalSwitches = 1;
    } else if (pickupStatus == 5 && deliveryStatus == 5) {
      totalSwitches = 1;
    }

    update();
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    kilometer = 12742 * asin(sqrt(a));
    distanceWiseDeliveryCharge();
    return kilometer.toStringAsFixed(2);
  }

  distanceWiseDeliveryCharge() {
    distanceDeliveryCharge = deliveryCharge;
    if (freeradius <= kilometer) {
      distanceDeliveryCharge += chargePerKilo * (kilometer - freeradius);
      distanceDeliveryCharge =
          double.parse(distanceDeliveryCharge.round().toString());
    }
    update();
  }
}
