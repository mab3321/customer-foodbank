import 'package:flutter/material.dart';
import '/screens/main_screen.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

class SearchErrorPage extends StatefulWidget {
  const SearchErrorPage({Key? key}) : super(key: key);

  @override
  _SearchErrorPageState createState() => _SearchErrorPageState();
}

class _SearchErrorPageState extends State<SearchErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/search.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'WE_ARE_SORRY'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.baseThemeColor,
                    fontSize: FontSize.xLarge),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                'NO_RESTAURANT_FOUND_THAT_YOU_ARE_LOOKING_FOR'.tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                'PLEASE_SEARCH_ANOTHER_RESTAURANT'.tr,
                style: TextStyle(
                    // fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 20,
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
                Get.off(MainScreen());
              },
              child: Text(
                'SEARCH_AGAIN'.tr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
