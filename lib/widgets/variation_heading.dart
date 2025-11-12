import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';
import '/theme/colors.dart';
import '/utils/theme_colors.dart';

class VariationHeading extends StatefulWidget {
  const VariationHeading({Key? key}) : super(key: key);

  @override
  _VariationHeadingState createState() => _VariationHeadingState();
}

class _VariationHeadingState extends State<VariationHeading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "VARIATION".tr,
                  style: TextStyle(
                      fontSize: FontSize.xMedium, fontWeight: FontWeight.w900),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: lightOrange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                  padding: EdgeInsets.all(7.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    '1REQUIRED'.tr,
                    style: TextStyle(
                        color: ThemeColors.baseThemeColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            Text("SELECT_ONE".tr,
                style: TextStyle(
                  fontSize: FontSize.xMedium,
                  color: Colors.grey,
                  // fontWeight: FontWeight.w300
                ))
          ],
        ));
  }
}
