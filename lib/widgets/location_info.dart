import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/theme/colors.dart';
import '/theme/styles.dart';
import '/utils/theme_colors.dart';

class LocationMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationMenuState();
  }
}

class _LocationMenuState extends State<LocationMenu> {
  var mainWidth;

  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 15,
          ),
          height: 45,
          width: mainWidth - 70,
          decoration: BoxDecoration(
              color: textFieldColor, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: ThemeColors.baseThemeColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("NEW_YORK".tr, style: customContent)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Icon(Icons.timelapse_outlined,
                            color: ThemeColors.baseThemeColor),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "NOW".tr,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Icon(
              Icons.filter,
              color: ThemeColors.baseThemeColor,
            ),
          ),
        )
      ],
    );
  }
}
