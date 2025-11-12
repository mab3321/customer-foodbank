import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/Controllers/global-controller.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/views/product_detail_page.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'no_menu_item_found.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<MenuPage> {
  var mainHeight, mainWidth;
  final restaurantDetailsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        body: GetBuilder<RestaurantDetailsController>(
          init: RestaurantDetailsController(),
          builder:
              (restaurantDetails) =>
                  restaurantDetails.menuItemList.isEmpty
                      ? NoMenuItemFound()
                      : SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: restaurantDetails.menuItemList.length,
                              itemBuilder:
                                  (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ProductsDetails(
                                            restaurantID:
                                                restaurantDetails.restaurantID,
                                            deliveryCharge:
                                                restaurantDetails
                                                    .restaurantDeliveryCharge,
                                            menuItemID:
                                                restaurantDetails
                                                    .menuItemList[index]
                                                    .id,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: mainWidth,
                                        child: Card(
                                          elevation: 1,
                                          shadowColor: Colors.blueGrey,
                                          margin: EdgeInsets.only(bottom: 5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    restaurantDetails
                                                        .menuItemList[index]
                                                        .image!,
                                                imageBuilder:
                                                    (
                                                      context,
                                                      imageProvider,
                                                    ) => Container(
                                                      width: mainWidth / 3,
                                                      height: mainHeight / 6,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                    10.0,
                                                                  ),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    10.0,
                                                                  ),
                                                            ),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                          //alignment: Alignment.topCenter,
                                                        ),
                                                      ),
                                                    ),
                                                placeholder:
                                                    (
                                                      context,
                                                      url,
                                                    ) => Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        height: mainHeight / 6,
                                                        width: mainWidth / 3,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              "assets/images/farmhouse.jpg",
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),

                                              //menu_description section
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  child: Column(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Flexible(
                                                              child: Text(
                                                                '${restaurantDetails.menuItemList[index].name}',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "${Get.find<GlobalController>().currencyCode}${restaurantDetails.menuItemList[index].unitPrice}",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 30),
                                                      Text(
                                                        "${restaurantDetails.menuItemList[index].description}",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.grey,
                                                        ),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
        ),
      ),
    );
  }

  ratingBar() {
    return RatingBar.builder(
      itemSize: 20,
      initialRating: 3.5,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      //itemPadding: EdgeInsets.symmetric(horizontal:2.0),
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
