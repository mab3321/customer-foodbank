import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllRestaurantsHeading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllRestaurantsHeadingState();
  }
}

class _AllRestaurantsHeadingState extends State<AllRestaurantsHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "MOSTLY_VISITED_RESTAURANTS".tr,
            style: TextStyle(
                fontFamily: 'AirbnbCerealBold',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
