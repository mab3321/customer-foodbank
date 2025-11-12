import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import 'package:shimmer/shimmer.dart';

class DescriptionContainerShimmer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DescriptionContainerShimmerState();
  }
}

class _DescriptionContainerShimmerState
    extends State<DescriptionContainerShimmer> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Container(
      //height: 300,
      width: mainWidth,
      child: Column(
        children: [
          ListTile(
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: Text(
                "Restaurant Name",
                style: TextStyle(
                  fontSize: FontSize.xxLarge,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Text(
                    'Open: ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Text(
                    'Opening time-Closing time',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Rating Number",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Number of reviews",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded,
                      color: Colors.orange, size: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
