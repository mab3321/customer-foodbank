import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '/Controllers/cart_controller.dart';
import '/Controllers/global-controller.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '/views/no_cart_found.dart';
import '/widgets/fixed_checkout_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var mainHeight, mainWidth;
  final cartController = Get.put(CartController());
  var value = 0;
  var qtyValue = 0;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cert) => Scaffold(
            bottomNavigationBar: cert.cart.isEmpty
                ? Container(height: mainHeight / 4)
                : CheckoutBottomBar(),
            appBar: AppBar(
              title: Text(
                "CART".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.large,
                    color: Colors.white),
              ),
              backgroundColor: ThemeColors.baseThemeColor,
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print(cert.totalSwitches.toString());
                        },
                        child: Text(
                          "CHOOSE_ORDER_TYPE".tr,
                          style: TextStyle(
                              fontSize: FontSize.large,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      cartController.totalSwitches == 0
                          ? Container()
                          : Container(
                              height: 40,
                              child: ToggleSwitch(
                                minWidth: 80.0,
                                cornerRadius: 15.0,
                                activeBgColors: [
                                  [ThemeColors.baseThemeColor],
                                  [ThemeColors.baseThemeColor],
                                ],
                                activeFgColor: Colors.white,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex:
                                    cartController.pickMethodIndex,
                                customTextStyles: [
                                  TextStyle(
                                      fontSize: FontSize.xMedium,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ],
                                totalSwitches: cert.totalSwitches,
                                labels: cert.orderTypeLabel,
                                radiusStyle: true,
                                onToggle: (index) {
                                  if (cert.totalSwitches == 2) {
                                    setState(() {
                                      cartController.pickMethod = index!;
                                      cartController.pickMethodIndex = index;
                                    });
                                  } else if (cert.deliveryStatus == 5) {
                                    setState(() {
                                      cartController.pickMethod = 0;
                                      cartController.pickMethodIndex = 0;
                                    });
                                  } else if (cert.pickupStatus == 5) {
                                    cartController.pickMethod = 1;
                                    cartController.pickMethodIndex = 0;
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                cert.cart.isEmpty
                    ? NoCardFound()
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cert.cart.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: cert.cart[index].imgUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: mainWidth / 5,
                                  width: mainWidth / 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: Container(
                                    height: mainWidth / 5,
                                    width: mainWidth / 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/farmhouse.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              title: Text(
                                "${cert.cart[index].name}",
                                style: TextStyle(
                                  fontSize: FontSize.xMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              subtitle: Text(
                                "${Get.find<GlobalController>().currencyCode!}${cert.cart[index].price} X ${cert.cart[index].qty} = ${Get.find<GlobalController>().currencyCode!}${cert.cart[index].price! * cert.cart[index].qty!}",
                                style: TextStyle(
                                    //fontSize: FontSize.xMedium,
                                    //fontWeight: FontWeight.bold,

                                    ),
                              ),

                              trailing: Container(
                                width: mainWidth / 3,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          var qty = cert.cart[index].qty! - 1;
                                          cert.updateProduct(
                                              cert.cart[index].id,
                                              cert.cart[index].price.toString(),
                                              qty);
                                        });
                                      },
                                    ),
                                    Text(
                                      '${cert.cart[index].qty}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          var qty = cert.cart[index].qty! + 1;
                                          cert.updateProduct(
                                              cert.cart[index].id,
                                              cert.cart[index].price.toString(),
                                              qty);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: ThemeColors.baseThemeColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //trailing:Add_to_cart_column(),
                            );
                          },
                        ),
                      ),
              ],
            )));
  }
}
