import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ex/Controllers/checkout_controller.dart';
import 'package:get/get.dart';

class PaystackService {
  PaystackService({
    required this.context,
    required this.payStackKey,
    required this.phoneNumber,
    required this.address,
    required this.price,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.orderTypeSelect,
  });

  BuildContext context;

  int? price;
  int? orderTypeSelect;

  String? payStackKey;
  String? email;
  String? phoneNumber;
  String? address;
  String? latitude;
  String? longitude;

  PaystackPlugin payStack = PaystackPlugin();

  CheckoutController checkoutController = Get.put(CheckoutController());

  //Reference

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin(payStackKey) async {
    await payStack.initialize(publicKey: payStackKey);
  }

  //Method Charging card
  chargeCardAndMakePayment() async {
    initializePlugin(payStackKey).then((_) async {
      Charge charge = Charge()
        ..amount = price! * 100
        ..email = email
        ..currency = 'NGN'
        ..reference = _getReference()
        ..card = _getCardUI();

      CheckoutResponse response = await payStack.checkout(
        context,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: FlutterLogo(
          size: 24,
        ),
      );

      if (response.status == true) {
        _handlePaymentSuccess(response);
      } else {
        _handlePaymentError();
      }
    });
  }

  void _handlePaymentSuccess(response) async {
    Fluttertoast.showToast(msg: "SUCCESS!", toastLength: Toast.LENGTH_SHORT);
    checkoutController.postOrder(
        this.phoneNumber, true, response.reference, this.orderTypeSelect, '17');
  }

  void _handlePaymentError() {
    Fluttertoast.showToast(msg: "ERROR", toastLength: Toast.LENGTH_SHORT);
  }
}
