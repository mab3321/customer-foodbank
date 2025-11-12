import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '/Controllers/banner_controller.dart';
import '/views/restaurant_details.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

/*
 * for slider home page
 */
class CustomSliderWidget extends StatefulWidget {
  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  int activeIndex = 0;
  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      init: BannerController(),
      builder: (banner) => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: banner.bannerList.length,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setActiveDot(index);
                  },
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                ),
                itemBuilder: (BuildContext context, itemIndex, realIndex) {
                  return InkWell(
                    onTap: () {
                      Get.to(RestaurantDetails(
                          id: banner.bannerList[itemIndex].restaurantId));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: banner.bannerList[itemIndex].image!,
                        imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 0,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banner.bannerList.length, (idx) {
                return activeIndex == idx ? ActiveDot() : InactiveDot();
              }),
            ),
          )
        ],
      ),
    );
  }
}
