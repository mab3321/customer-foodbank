import 'package:flutter/material.dart';
import '/views/view_all_cuisines_list.dart';
import 'package:get/get.dart';

class CuisineHeading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CuisineHeadingState();
  }
}

class _CuisineHeadingState extends State<CuisineHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "POPULAR_CUISIONES".tr,
            style: TextStyle(
                fontFamily: 'AirbnbCerealBold',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          InkWell(
            onTap: (() {
              Get.to(() => ViewAllCuisines());
            }),
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "VIEW_ALL".tr,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13,
                      fontFamily: 'AirbnbCerealBold',
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 13,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
