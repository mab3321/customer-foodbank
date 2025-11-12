import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/image.dart';
import '/utils/size_config.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: () => Get.back())),
        title: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[400]!,
          child: Text(
            "Order Details",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: FontSize.xLarge,
                color: Colors.grey),
          ),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: MediaQuery.of(context).size.height / 3.5,
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        child: Text(
                          'Sub Total',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                          child: Text(
                        "\$ 00",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                          child: Text(
                        'Delivery Fee',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                          child: Text(
                        "\$ 00",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                          child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                          child: Text(
                        "\$ 000",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.fromBorderSide(
                              BorderSide(color: ThemeColors.baseThemeColor))),
                      child: Center(
                          child: Text('Details',
                              style: TextStyle(color: Colors.grey))),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.fromBorderSide(
                              BorderSide(color: ThemeColors.baseThemeColor))),
                      child: Center(
                          child: Text('Tracking Order',
                              style: TextStyle(color: Colors.grey))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "Order No. #00",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "\$000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "Order orderStatus",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "00-00-0000 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "Items: 0 ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //   Stepper
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: Text(
                          "Ordered Items",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 2),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  leading: Shimmer.fromColors(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width / 5,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image:
                                                AssetImage(Images.shimmerImage),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                  ),
                                  title: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Text(
                                      "Item Name",
                                      style: TextStyle(
                                        fontSize: FontSize.xMedium,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  subtitle: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Text(
                                      "\$00 x 00 = \$000",
                                      style: TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: FontSize.medium,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  trailing: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Text(
                                      "\$00",
                                      style: TextStyle(
                                        fontSize: FontSize.medium,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ]),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Container(
                    height: 500,
                    width: 600,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
