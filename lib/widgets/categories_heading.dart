import 'package:flutter/material.dart';
import '/views/view_all_category.dart';
import 'package:get/get.dart';

class CategoriesHeading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesHeadingState();
  }
}

class _CategoriesHeadingState extends State<CategoriesHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TOP_CATEGORIES".tr,
            style: TextStyle(
                fontFamily: 'AirbnbCerealBold',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          InkWell(
            onTap: (() {
              Get.to(ViewAllCategories());
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
                      fontSize: 13,
                      color: Colors.grey,
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
