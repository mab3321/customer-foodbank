import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/category_Controller.dart';
import '/theme/styles.dart';
import '/views/category_all_restaurants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesListSTate();
  }
}

class _CategoriesListSTate extends State<CategoriesList> {
  var mainHeight, mainWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (categories) => RefreshIndicator(
              onRefresh: categories.onRefreshScreen,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                  child: Row(
                    children: List.generate(categories.categoriesList.length,
                        (index) {
                      return InkWell(
                        onTap: (() {
                          Get.to(() => CateegoryAllRestaurents(
                                categoryId: categories.categoriesList[index].id,
                                categoryTitle:
                                    categories.categoriesList[index].title,
                              ));
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: mainWidth / 5,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      categories.categoriesList[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Image(
                                    image: imageProvider,
                                    height: 50,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    child: Container(
                                        height: 60,
                                        width: 200,
                                        color: Colors.grey),
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "${categories.categoriesList[index].title}",
                                    style: customParagraph,
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
              ),
            ));
  }
}
