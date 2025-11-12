import 'package:flutter/material.dart';
import '/utils/image.dart';
import '/utils/theme_colors.dart';
import 'package:shimmer/shimmer.dart';

class CuisineShimmer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CuisineShimmerState();
}

class _CuisineShimmerState extends State<CuisineShimmer> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[400]!,
      child: Container(
        height: mainHeight / 7,
        //width: mainWidth/3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.only(left: 15),
                width: mainWidth / 2,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: const Color(0xff7c94b6),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(Images.shimmerImage),
                        fit: BoxFit.cover,

                        //alignment: Alignment.topCenter,
                      ),
                    ),
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
                        'cuisiner',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]));
          },
        ),
      ),
    );
  }
}
