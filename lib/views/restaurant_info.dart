import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controllers/cart_controller.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/theme_colors.dart';
import '/views/cart.dart';
import '/widgets/tab_bar.dart';

class RestaurantInfo extends StatefulWidget {
  final int? id;

  RestaurantInfo({required this.id});

  @override
  State<StatefulWidget> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  var mainHeight, mainWidth;
  final restaurantDetailsController = Get.put(RestaurantDetailsController());
  final cartController = Get.put(CartController());

  Future<Null> _refresh() async {
    restaurantDetailsController.getRestaurant(widget.id!);
    await Future.delayed(new Duration(seconds: 3));
  }

  @override
  void initState() {
    restaurantDetailsController.getRestaurant(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<RestaurantDetailsController>(
      init: RestaurantDetailsController(),
      builder:
          (restaurant) => RefreshIndicator(
            onRefresh: _refresh,
            child: Scaffold(
              floatingActionButton: Stack(children: <Widget>[]),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              restaurantDetailsController.restaurantImage ?? "",
                        ),
                        Positioned(
                          top: 32,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   height: 45,
                              //   width: 45,
                              //   child: FittedBox(
                              //     child: FloatingActionButton(
                              //       heroTag: "backButton",
                              //       elevation: 5,
                              //       backgroundColor: ThemeColors.baseThemeColor,
                              //       onPressed: () {
                              //         Get.back();
                              //       },
                              //       child: Padding(
                              //         padding: const EdgeInsets.only(left: 5),
                              //         child: Icon(
                              //           Icons.arrow_back_ios,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              GetBuilder<CartController>(
                                init: CartController(),
                                builder:
                                    (cart) => Stack(
                                      children: [
                                        SizedBox(
                                          height: 45,
                                          width: 45,
                                          child: FittedBox(
                                            child: FloatingActionButton(
                                              heroTag: "cart",
                                              onPressed: () {
                                                Get.to(() => CartPage());
                                              },
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              backgroundColor:
                                                  ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ),
                                        new Positioned(
                                          child: new Stack(
                                            children: <Widget>[
                                              new Icon(
                                                Icons.brightness_1,
                                                size: 20.0,
                                                color: Colors.orange,
                                              ),
                                              new Positioned(
                                                top: 4.0,
                                                right: 5.5,
                                                child: new Center(
                                                  child: new Text(
                                                    cart.totalQunty.toString(),
                                                    style: new TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TabBarDemo(),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
