import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';

class NoMenuReviewFound extends StatefulWidget {
  const NoMenuReviewFound({Key? key}) : super(key: key);

  @override
  _NoMenuReviewFoundState createState() => _NoMenuReviewFoundState();
}

class _NoMenuReviewFoundState extends State<NoMenuReviewFound> {
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
                "NO_REVIEW_FOUND".tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: FontSize.xLarge,
                    color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                "YOU_HAVENOT_REVIEWED_OUR_RESTAURANT".tr,
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
