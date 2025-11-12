import 'package:flutter/material.dart';
import '/screens/main_screen.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

class ConfirmationPage extends StatefulWidget {
  final tabelBook;
  ConfirmationPage(this.tabelBook);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text('CONFIRMATION'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/thum.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'THANK_YOU'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'FOR_RESERVATION'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            child: Column(
              children: [
                Text(
                  'YOUR_BOOKING_HAS_BEEN_CONFIRMED_FOR'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  widget.tabelBook['reservation_date'].toString() + 'YOU'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'HAVE_BOOKED'.tr +
                      widget.tabelBook['table'].toString() +
                      'FOR'.tr +
                      widget.tabelBook['guest'].toString() +
                      'SEAT'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'AND_TIME_SLOT_IS'.tr + widget.tabelBook['slot'].toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.baseThemeColor,
                  ),
                  icon: Icon(
                    Icons.add,
                    size: 26,
                  ),
                  label: Text(
                    'BOOK_MORE_TABLE'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  icon: Icon(
                    Icons.home,
                    size: 26,
                    color: ThemeColors.baseThemeColor,
                  ),
                  label: Text(
                    'HOME'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                  onPressed: () {
                    Get.off(() => MainScreen());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
