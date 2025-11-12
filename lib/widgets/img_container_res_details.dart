import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../Controllers/cart_controller.dart';
import '../utils/theme_colors.dart';
import '../views/cart.dart';

class ImageContainer extends StatefulWidget {
  final img;
  ImageContainer({required this.img});
  @override
  State<StatefulWidget> createState() {
    return _ImageContainerState();
  }
}

class _ImageContainerState extends State<ImageContainer> {
  var mainHeight, mainWidth;
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.img,
            imageBuilder:
                (context, imageProvider) => Container(
                  padding: EdgeInsets.only(bottom: 15),
                  height: mainHeight / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.0),
                      topRight: Radius.circular(2.0),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            placeholder:
                (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 15),
                    height: mainHeight / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        topRight: Radius.circular(2.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/farmhouse.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: "backButton",
                      elevation: 5,
                      backgroundColor: ThemeColors.baseThemeColor,
                      onPressed: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                  ),
                ),
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
                                backgroundColor: ThemeColors.baseThemeColor,
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
                                        fontWeight: FontWeight.w900,
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
    );
  }
}
