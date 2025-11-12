import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';

class InformationBookTable extends StatefulWidget {
  const InformationBookTable({Key? key}) : super(key: key);

  @override
  _InformationBookTableState createState() => _InformationBookTableState();
}

class _InformationBookTableState extends State<InformationBookTable> {
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "YOUR_INFORMATION".tr,
            style: TextStyle(
              fontSize: FontSize.xLarge,
              fontWeight: FontWeight.bold,
              fontFamily: 'AirbnbCerealBold',
            ),
          ),

          //Phone textfield
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: titleController,
              //style: textStyle,
              onChanged: (value) {
                upDatePhone();
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,
                      color: ThemeColors.baseThemeColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeColors.baseThemeColor, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  hintText: 'ENTER_YOUR_EMAIL'.tr,
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  labelText: 'EMAIL'.tr,
                  labelStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),

          //Phone textfield
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: titleController,
              //style: textStyle,
              onChanged: (value) {
                upDatePhone();
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: ThemeColors.baseThemeColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeColors.baseThemeColor, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  hintText: 'ENTER_YOUR_PHONE_NUMBER'.tr,
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  labelText: 'PHONE'.tr,
                  labelStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
        ],
      ),
    );
  }

  void upDatePhone() {}
}
