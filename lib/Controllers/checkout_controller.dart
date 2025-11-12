import 'dart:convert';

import 'package:get/get.dart';

import '/Controllers/cart_controller.dart';
import '/models/cart_model.dart';
import '/models/profile_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import '/views/order_confirmation_page.dart';
import 'address_controller.dart';

class CheckoutController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  String? userID;
  int? orderId;
  double discount = 0;
  String discountID = '';
  bool checkoutLoader = true;
  List<Map> items = [];
  List<Map> paymentOptions = [];
  String? name, email, username, phone, address, image, credit;

  //

  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }

  getUserProfile() {
    server.getRequest(endPoint: APIList.profile).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var profileData = Profile.fromJson(jsonResponse);
        name = profileData.data!.data!.name;
        email = profileData.data!.data!.email;
        address = profileData.data!.data!.address;
        phone = profileData.data!.data!.phone;
        username = profileData.data!.data!.username;
        image = profileData.data!.data!.image;
        credit = profileData.data!.data!.balance;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }

  postOrder(
      phoneNumber, payment, paymentID, orderTypeSelect, paymentTypeID) async {
    Get.find<CartController>().cart.forEach((element) => items.add(ItemProduct(
            restaurantId: Get.find<CartController>().restaurantId,
            menuItemId: element.id,
            unitPrice: element.price,
            discountedPrice: 0.0,
            quantity: element.qty,
            instructions: element.instructions,
            menuItemVariationId: element.variationId,
            options: element.options)
        .toJsonData()));

    Map body = {
      "items": json.encode(items),
      "mobile": phoneNumber,
      "address": Get.find<AddressController>().addressName, 
      "addressLabel": Get.find<AddressController>().addressLabelName,
      "delivery_charge": orderTypeSelect == 0
          ? Get.find<CartController>().distanceDeliveryCharge
          : '0',
      "order_type": orderTypeSelect == 0 ? 1 : 2,
      "lat": Get.find<AddressController>().addressLat,
      "long": Get.find<AddressController>().addressLong,
      "remarks": 'remarks',
      "total": Get.find<CartController>().totalCartValue -
          Get.find<CheckoutController>().discount,
      "restaurant_id": Get.find<CartController>().restaurantId,
      "coupon_id": Get.find<CheckoutController>().discountID,
      "coupon_amount": Get.find<CheckoutController>().discount,
    };

    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.orders, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        orderId = jsonResponse['data']['order_id'];
        if (payment) {
          paymentOrder(orderId, jsonResponse['data']['total_amount'], paymentID,
              paymentTypeID);
        } else {
          Get.off(() => OrderConfirmation(
                orderId: orderId,
                totalAmount: jsonResponse['data']['total_amount'].toString(),
                subTotal: Get.find<CartController>().totalCartValue.toString(),
                deliveryCharge: orderTypeSelect == 0
                    ? Get.find<CartController>()
                        .distanceDeliveryCharge
                        .toString()
                    : '0',
                discount: Get.find<CheckoutController>().discount.toString(),
              ));
        }
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  paymentOrder(orderID, amount, paymentID, paymentTypeID) async {
    Map body = {
      'order_id': orderID,
      'amount': amount,
      'payment_method': paymentTypeID,
      'payment_transaction_id': paymentID,
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.ordersPayment, body: jsonBody)
        .then((response) {

      if (response != null && response.statusCode == 200) {
        Get.off(
          () => OrderConfirmation(
            orderId: orderID,
            totalAmount: amount,
            subTotal: Get.find<CartController>().totalCartValue.toString(),
            deliveryCharge:
                Get.find<CartController>().distanceDeliveryCharge.toString(),
            discount: Get.find<CheckoutController>().discount.toString(),
          ),
        );
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  postVoucherCode(discountCode) async {
    Map body = {
      "coupon": discountCode,
      "restaurantID": Get.find<CartController>().restaurantId,
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.coupon, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['data']['coupon']['discount_type'].toString() == '5') {
          discount =
              double.parse(jsonResponse['data']['coupon']['amount'].toString());
        } else {
          discount = (Get.find<CartController>().totalCartValue *
                  double.parse(
                      jsonResponse['data']['coupon']['amount'].toString())) /
              100;
        }
        update();
        Get.back();
      } else if (response != null && response.statusCode == 422) {
        final jsonResponse = json.decode(response.body);
        Get.rawSnackbar(
          message: jsonResponse['data']['msg'],
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.rawSnackbar(
          message: 'Please enter valid input',
          snackPosition: SnackPosition.TOP,
        );
      }
    });
    Future.delayed(Duration(milliseconds: 5), () {
      update();
    });
  }
}
