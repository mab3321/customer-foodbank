import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderListShimmer extends StatefulWidget {
  const OrderListShimmer({Key? key}) : super(key: key);

  @override
  _OrderListShimmerState createState() => _OrderListShimmerState();
}

class _OrderListShimmerState extends State<OrderListShimmer> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: ExpansionTile(
              title: Container(
                padding: EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Text(
                        "Order No. #00",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                    ),
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: Text(
                            "Process",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
