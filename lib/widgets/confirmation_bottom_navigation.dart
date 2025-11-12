import 'package:flutter/material.dart';
import '/utils/theme_colors.dart';
import '/views/orders_List.dart';
import 'package:get/get.dart';

class ConfirmationBottomSheeet extends StatefulWidget {
  const ConfirmationBottomSheeet({Key? key}) : super(key: key);

  @override
  _ConfirmationBottomSheeetState createState() =>
      _ConfirmationBottomSheeetState();
}

class _ConfirmationBottomSheeetState extends State<ConfirmationBottomSheeet> {
  var mainHeight, mainWidth;
  var cartValue = 2;

  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: mainHeight / 3.5,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Container(
                      child: Text(
                    "\$36.06",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
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
                    'DELIVERY_FEE'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Container(
                      child: Text(
                    "\$10.06",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
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
                    'Tax (7.08%)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Container(
                      child: Text(
                    "\$2.86",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                    'TOTAL'.tr,
                    style: TextStyle(
                        color: ThemeColors.baseThemeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Text(
                    "\$2.86",
                    style: TextStyle(
                      color: ThemeColors.baseThemeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
                ],
              ),
            ),
            // SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: mainWidth,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.baseThemeColor, // background
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    Get.to(OrderList());
                  });
                },
                child: Text(
                  'MY_ORDERS'.tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ));
  }
}
