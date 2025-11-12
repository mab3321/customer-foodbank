import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

class ViewRestaurantPage extends StatefulWidget {
  const ViewRestaurantPage({Key? key}) : super(key: key);

  @override
  _ViewRestaurantPageState createState() => _ViewRestaurantPageState();
}

class _ViewRestaurantPageState extends State<ViewRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          'RESTAURANT1'.tr,
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
            itemCount: 2,
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
                        //add image
                        Container(
                          padding: EdgeInsets.only(bottom: 15),
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.0),
                                topRight: Radius.circular(2.0)),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/buffet_stories.jpeg'),
                              fit: BoxFit.fill,
                              //alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            //  leading:CircleAvatar(backgroundImage:AssetImage("assets/images/pizza_hut") ,) ,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'RESTAURANT_NAME'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "THIS_IS_THE_BEST_RESTAURANT_IN_MY_TOWN".tr,
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "DHAKA".tr,
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      itemSize: 20,
                                      initialRating: 4,
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "10REVIEWS".tr,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
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
