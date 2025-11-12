import 'package:flutter/material.dart';
import '/Controllers/cart_controller.dart';
import '/Controllers/global-controller.dart';
import '/utils/theme_colors.dart';
import '/views/checkout_page.dart';
import 'package:get/get.dart';

class CheckoutBottomBar extends StatefulWidget {
  const CheckoutBottomBar({Key? key, String}) : super(key: key);

  @override
  _CheckoutBottomBarState createState() => _CheckoutBottomBarState();
}

class _CheckoutBottomBarState extends State<CheckoutBottomBar> {
  var mainHeight, mainWidth;
  var cartValue = 2;
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (cert) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: mainHeight / 3.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(
                      'SUB_TOTAL'.tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                    Container(
                        child: Text(
                      "${Get.find<GlobalController>().currencyCode!}${cert.totalCartValue}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      Container(
                          child: Text(
                        cert.cart.length == 0
                            ? "${Get.find<GlobalController>().currencyCode!}0.0"
                            : "${Get.find<GlobalController>().currencyCode!}${cert.distanceDeliveryCharge}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                    ],
                  ),
                ),
              //SizedBox(height: 5,),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    cartController.pickMethod == 0
                        ? Text(
                            cert.cart.length == 0
                                ? "${Get.find<GlobalController>().currencyCode!}0.0"
                                : "${Get.find<GlobalController>().currencyCode!}${(cert.totalCartValue + cert.distanceDeliveryCharge).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            cert.cart.length == 0
                                ? "${Get.find<GlobalController>().currencyCode!}0.0"
                                : "${Get.find<GlobalController>().currencyCode!}${cert.totalCartValue}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
              cartController.totalSwitches == 0
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Flexible(
                        child: Text(
                          'CURRENTLY_THIS_RESTAURANT_IS_NOT_ACCEPTING_ANY_ORDER'
                              .tr,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                    )
                  : // SizedBox(height: 10,),
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
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            Get.to(() => CheckoutPage());
                          });
                        },
                        child: Text(
                          'CHECKOUT'.tr,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}
