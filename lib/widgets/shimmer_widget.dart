import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  // const ShimmerWidget ({Key? key}) : super(key: key);
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {required this.height,
      required this.width,
      this.shapeBorder = const RoundedRectangleBorder()});

  const ShimmerWidget.circle({
    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: height,
          width: width,
          decoration: ShapeDecoration(color: Colors.grey, shape: shapeBorder),
        ),
      );
}
