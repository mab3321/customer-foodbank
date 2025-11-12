import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/theme_colors.dart';
import '/views/no_review_found.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key}) : super(key: key);

  final restaurantDetailsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RestaurantDetailsController>(
        init: RestaurantDetailsController(),
        builder: ((res) => res.reviewList.isEmpty
            ? NoMenuReviewFound()
            : Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                  itemCount: res.reviewList.length,
                  itemBuilder: (ctx, index) => Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: res.reviewList[index].userImage!,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 25,
                                    backgroundImage: imageProvider,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          'assets/images/pickup.png'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(res.reviewList[index].user!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      _iconWithText(
                                          Icon(Icons.star,
                                              size: 15,
                                              color:
                                                  ThemeColors.baseThemeColor),
                                          '${res.reviewList[index].rating} ' +
                                              'STAR_RATING'.tr),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${res.reviewList[index].review}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
      ),
    );
  }

  _iconWithText(Widget icon, String content) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            icon,
            SizedBox(width: 2),
            Flexible(
              child: Text(
                content,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ],
        ),
      );
}
