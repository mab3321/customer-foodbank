import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '/Controllers/checkout_controller.dart';
import '/models/razor_pay.dart';

class RazorPayService {
  RazorPay? razorPay;

  RazorPayService(this.razorPay);

  final checkoutController = Get.put(CheckoutController());

  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;
  void init() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': razorPay?.razorpayKey,
      'amount': razorPay!.amount! * 100,
      'name': '${razorPay!.name}.',
      'description': '${razorPay!.description}',
      'prefill': {
        'contact': '${razorPay!.phone}',
        'email': '${razorPay!.email}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var paymentId = response.paymentId;

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    checkoutController.postOrder(razorPay!.phone!.trim(), true, paymentId,
        razorPay!.orderTypeSelect, '16');

    paymentId = null;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
