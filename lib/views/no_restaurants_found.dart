import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

class NoRestaurantFound extends StatefulWidget {
  const NoRestaurantFound({Key? key}) : super(key: key);

  @override
  _NoRestaurantFoundState createState() => _NoRestaurantFoundState();
}

class _NoRestaurantFoundState extends State<NoRestaurantFound> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
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
                "NO_RESTAURANT_FOUND".tr,
                style: TextStyle(

                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.xLarge,
                    color: Colors.black87),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.baseThemeColor, // background
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'GO_BACK'.tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
