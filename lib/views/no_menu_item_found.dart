import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';

class NoMenuItemFound extends StatefulWidget {
  const NoMenuItemFound({Key? key}) : super(key: key);

  @override
  _NoMenuItemFoundState createState() => _NoMenuItemFoundState();
}

class _NoMenuItemFoundState extends State<NoMenuItemFound> {
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
                "NO_MENU_ITEM_FOUND".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.xLarge,
                    color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                "THE_MENU_ITEM_LIST_IS_EMPTY".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.medium,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
