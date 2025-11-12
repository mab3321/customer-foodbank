import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CateegoryAllRestaurentsShimmer extends StatelessWidget {
  final categoryId, categoryTitle;
  CateegoryAllRestaurentsShimmer(
      {required this.categoryId, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
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
      body: Container(
        color: Colors.white10,
        child: ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    // Get.to(Restaurant_Details(id: popularRestaurant.bestSellingRestaurantList[index].id,));
                  },
                  child: Card(
                    //shadowColor: Colors.grey,
                    elevation: 1,
                    // shadowColor: Colors.blueGrey,
                    margin: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: <Widget>[
                        Shimmer.fromColors(
                          child: Container(
                              height: 130, width: 200, color: Colors.grey),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            //  leading:CircleAvatar(backgroundImage:AssetImage("assets/images/pizza_hut") ,) ,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  'name',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: Text(
                                    "description",
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: Text(
                                    "address",
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                      child: RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: 4.5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: ThemeColors.baseThemeColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[400]!,
                                          child: Text(
                                            "0  reviews",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ))
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
    );
  }
}
