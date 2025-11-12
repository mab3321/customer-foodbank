import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';

class NoOverviewFoundPage extends StatelessWidget {
  const NoOverviewFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Image(
                  image: AssetImage(
                    "assets/images/no_restaurant_found.png",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "NO_OVERVIEW_FOUND".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.xLarge,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
