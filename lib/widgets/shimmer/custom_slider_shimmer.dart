import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


/*
 * for slider home page
 */
class CustomSliderShimmer extends StatefulWidget {

  @override
  _CustomSliderShimmerState createState() => _CustomSliderShimmerState();
}

class _CustomSliderShimmerState extends State<CustomSliderShimmer> {


  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Container(
          height: 600,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.grey,
        ),
      );

  }
}
