import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '../Controllers/checkout_controller.dart';

class VoucherCodePage extends StatefulWidget {
  const VoucherCodePage({Key? key}) : super(key: key);

  @override
  _VoucherCodePageState createState() => _VoucherCodePageState();
}

class _VoucherCodePageState extends State<VoucherCodePage> {
  var mainHeight, mainWidth;
  final checkoutController = Get.put(CheckoutController());
  late final TextEditingController discountCodeController =
      TextEditingController();

  var value = 0;
  var qtyValue = 0;
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<CheckoutController>(
        init: CheckoutController(),
        builder: (checkout) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'ADD_VOUCHER'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.large,
                      color: Colors.white),
                ),
                backgroundColor: ThemeColors.baseThemeColor,
                centerTitle: true,
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2.25,
                      width: mainWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300, // red as border color
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(
                                      const IconData(0xf0547,
                                          fontFamily: 'MaterialIcons'),
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'ADD_VOUCHER'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: ThemeColors.baseThemeColor),
                                    ),
                                  ],
                                )),

                            Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 2, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DISCOUNT_CODE".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5, top: 10),
                                child: SizedBox(
                                  height: 68,
                                  child: TextFormField(
                                    controller: discountCodeController,
                                    obscureText: false,
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    cursorColor: ThemeColors.baseThemeColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 0,
                                        left: 15,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      hintText: 'ENTER_YOUR_VOUCHER_CODE'.tr,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ENTER_YOUR_VOUCHER_CODE'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            //changehere
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 2, top: 2),
                                child: discountCodeController.text != ''
                                    ? Container(
                                        height: 50,
                                        color: Colors.grey,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                height: 40,
                                                child: Text(
                                                  "APPLY_CODE".tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    : InkWell(
                                        child: Container(
                                            height: 50,
                                            color: ThemeColors.baseThemeColor,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    height: 40,
                                                    child: Text(
                                                      'APPLY_CODE'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        onTap: () {
                                          checkout.postVoucherCode(
                                              discountCodeController.text);
                                        },
                                      ))
                          ]))),
            ));
  }
}
