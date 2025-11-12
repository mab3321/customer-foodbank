import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/Controllers/category_wise_restaurants.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '/views/restaurant_details.dart';
import '/widgets/shimmer/restaurant_by_categories_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'no_restaurants_found.dart';

class CateegoryAllRestaurents extends StatelessWidget {
  final categoryId, categoryTitle;
  CateegoryAllRestaurents(
      {required this.categoryId, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    var mainHeight;

    mainHeight = MediaQuery.of(context).size.height;

    print(categoryTitle);
    print(categoryId);

    return GetBuilder<CategoryWiseRestaurants>(
      init: CategoryWiseRestaurants(categoryId),
      builder: (allRestaurants) => allRestaurants.categoryWiseRestaurantsLoader
          ? CateegoryAllRestaurentsShimmer(
              categoryId: categoryId,
              categoryTitle: categoryTitle,
            )
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                title: Text(
                  categoryTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: FontSize.xLarge,
                      color: Colors.white),
                ),
                backgroundColor: ThemeColors.baseThemeColor,
                centerTitle: true,
                elevation: 0.0,
              ),
              body: allRestaurants.restaurantList.isEmpty
                  ? NoRestaurantFound()
                  : Container(
                      color: Colors.white10,
                      child: ListView.builder(
                          //   physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allRestaurants.restaurantList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(RestaurantDetails(
                                    id: allRestaurants.restaurantList[index].id,
                                  ));
                                },
                                child: Card(
                                  //shadowColor: Colors.grey,
                                  elevation: 1,
                                  // shadowColor: Colors.blueGrey,
                                  margin: EdgeInsets.all(2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.stretch,

                                    children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: allRestaurants
                                            .restaurantList[index].image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          padding: EdgeInsets.only(bottom: 15),
                                          height: mainHeight / 4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(2.0),
                                                topRight: Radius.circular(2.0)),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                              //alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          child: Container(
                                              height: 130,
                                              width: 200,
                                              color: Colors.grey),
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[400]!,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: ListTile(
                                          //  leading:CircleAvatar(backgroundImage:AssetImage("assets/images/pizza_hut") ,) ,
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              '${allRestaurants.restaurantList[index].name}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),

                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${allRestaurants.restaurantList[index].description}",
                                                style: TextStyle(fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${allRestaurants.restaurantList[index].address}",
                                                style: TextStyle(fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    itemSize: 20,
                                                    initialRating:
                                                        allRestaurants
                                                            .restaurantList[
                                                                index]
                                                            .avgRating!
                                                            .toDouble(),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      "(${allRestaurants.restaurantList[index].avgRatingUser!.toInt()}) " +
                                                          "REVIEWS".tr,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ),
    );
  }
}
