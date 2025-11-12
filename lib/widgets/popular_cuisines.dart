import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/cuisine_controller.dart';
import '/utils/theme_colors.dart';
import '/views/cuisine_all_restaurants.dart';
import '/widgets/shimmer/popular_cuisines_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Cuisines extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisines> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<CuisineController>(
        init: CuisineController(),
        builder: (cuisine) => cuisine.cuisineLoader
            ? CuisineShimmer()
            : Container(
                height: mainHeight / 7,
                //width: mainWidth/3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cuisine.cuisineList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (() {
                        Get.to(() => CuisineAllRestaurents(
                            cuisineId: cuisine.cuisineList[index].id,
                            cuisineTitle: cuisine.cuisineList[index].name));
                      }),
                      child: Container(
                          padding: EdgeInsets.only(left: 15),
                          width: mainWidth / 2,
                          child: Stack(children: [
                            CachedNetworkImage(
                              imageUrl: cuisine.cuisineList[index].image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  // color: const Color(0xff7c94b6),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit
                                        .cover, //alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeColors.baseThemeColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '${cuisine.cuisineList[index].name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ])),
                    );
                  },
                ),
              ));
  }
}
