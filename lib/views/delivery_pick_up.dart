import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

import 'cart.dart';

class DeliveryPickUp extends StatefulWidget {
  const DeliveryPickUp({Key? key}) : super(key: key);

  @override
  _DeliveryPickUpState createState() => _DeliveryPickUpState();
}

class _DeliveryPickUpState extends State<DeliveryPickUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: ThemeColors.baseThemeColor,
            )),
        title: Text(
          "DELIVERY_OR_PICKUP".tr,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: FontSize.xLarge,
              color: ThemeColors.baseThemeColor),
        ),
        backgroundColor: Colors.white54,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: ThemeColors.baseThemeColor,
            ),
            tooltip: 'OPEN_SHOPPING_CART'.tr,
            onPressed: () {
              Get.to(CartPage());
              // handle the press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image.asset(
                "assets/images/pickup.png",
                fit: BoxFit.fill,
              ),
              title: Text("Pickup"),
              subtitle: Text("PICKUP_YOUR_PRODUCT_FROM_MARKET".tr),
            ),
          ),
          Container(
            color: Colors.white,
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: ThemeColors.baseThemeColor,
                  ),
                  onPressed: () {},
                ),
                leading: Image.asset(
                  "assets/images/credit_card.png",
                  fit: BoxFit.fill,
                ),
                title: Text("PAY_ON_PICKUP".tr),
                subtitle: Text("CLICK_TO_PAY_ON_PICKUP".tr),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image.asset("assets/images/Delivery_address.png",
                  fit: BoxFit.fill),
              title: Text("DELIVERY_ADDRESS".tr),
              subtitle: Text("CONFIRM_YOUR_DELIVERY_ADDRESS".tr),
            ),
          ),
          Container(
            color: Colors.white,
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: ThemeColors.baseThemeColor,
                  ),
                  onPressed: () {},
                ),
                leading: Image.asset("assets/images/delivery_Address.png"),
                title: Text("Mirpur-2,Dhaka-1216"),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.baseThemeColor, // background
                foregroundColor: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              onPressed: () async {
                // Get.to(Order_confirmation());
              },
              child: Text(
                'PLACE_ORDER'.tr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
