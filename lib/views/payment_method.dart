import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/size_config.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'delivery_pick_up.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "PAYMENT_MODE".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FontSize.large,
                color: ThemeColors.baseThemeColor),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ThemeColors.baseThemeColor,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: ThemeColors.baseThemeColor,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: ThemeColors.baseThemeColor,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter,
                        color: ThemeColors.baseThemeColor,
                      ),
                    ),
                    hintText: 'SEARCH_FOR_MARKETS_OR_PRODUCTS'.tr,
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: ThemeColors.baseThemeColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 0,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                  leading: Icon(
                    Icons.credit_card,
                    color: ThemeColors.baseThemeColor,
                  ),
                  title: Text(
                    "PAYMENT_OPTIONS".tr,
                    style: TextStyle(
                      fontSize: FontSize.large,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  subtitle: Text(
                    "SELECT_YOUR_PREFERRED_PAYMENT_MODE".tr,
                    style: TextStyle(color: Colors.grey[600]
                        //fontSize: FontSize.xMedium,
                        //fontWeight: FontWeight.bold,

                        ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => DeliveryPickUp());
                      },
                      child: ListTile(
                        leading: Container(
                          height: (SizeConfig.screenWidth)! / 3,
                          width: (SizeConfig.screenWidth)! / 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/visa.png"),
                                  fit: BoxFit.fill)),
                        ),

                        title: Text(
                          "VISA_CARD".tr,
                          style: TextStyle(
                            fontSize: FontSize.xMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          "CLICK_TO_PAY_WITH_YOUR_VISA_CARD".tr,
                          style: TextStyle(color: Colors.grey
                              //fontSize: FontSize.xMedium,
                              //fontWeight: FontWeight.bold,

                              ),
                        ),

                        trailing: Icon(Icons.arrow_forward_ios_sharp),

                        //trailing:Add_to_cart_column(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
