import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductsDetailsShimmer extends StatefulWidget {
  @override
  _ProductsDetailsShimmerState createState() => _ProductsDetailsShimmerState();
}

class _ProductsDetailsShimmerState extends State<ProductsDetailsShimmer> {
  var mainHeight, mainWidth;
  var cartValue = 1;
  var itemCount = 1;

  TextEditingController instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Container(
          height: 100,
          child: _addToCert(),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: Container(
                height: mainHeight / 4,
                width: mainWidth,
                child: Container(
                  padding: EdgeInsets.only(bottom: 15, top: 30),
                  height: mainHeight / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        topRight: Radius.circular(2.0)),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Text(
                      "Special instructions",
                      style: TextStyle(
                          fontSize: FontSize.xMedium,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Text(
                        "Please let us know if you are allergic to something or if we need to avoid anything",
                        style: TextStyle(
                          fontSize: FontSize.xMedium,
                          color: Colors.grey,
                          //fontWeight: FontWeight.w300
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Container(
                      height: 200,
                      child: TextFormField(
                        controller: instructionsController,
                        minLines: 2,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Enter your address',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addToCert() => Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: ThemeColors.baseThemeColor,
                ),
              ],
            ),
            Container(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.baseThemeColor, // background
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {},
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
