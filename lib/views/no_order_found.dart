import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';

class NoOrderFound extends StatefulWidget {
  const NoOrderFound({Key? key}) : super(key: key);

  @override
  _NoOrderFoundState createState() => _NoOrderFoundState();
}

class _NoOrderFoundState extends State<NoOrderFound> {
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
                "NO_ORDERS_YET".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.xLarge,
                    color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                "YOU_DONT_HAVE_ANY_ORDERS_YET".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.medium,
                    color: Colors.grey),
              ),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: ThemeColors.baseThemeColor, // background
              //     onPrimary: Colors.white, // foreground
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10), // <-- Radius
              //     ),
              //   ),
              //   onPressed: () {
              //     Get.back();
              //   },
              //   child: Text(
              //     'Go back',
              //     style: TextStyle(
              //         color: Colors.white, fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
