import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class PopularRestaurantShimmer extends StatefulWidget {
  const PopularRestaurantShimmer({Key? key}) : super(key: key);

  @override
  _PopularRestaurantShimmerState createState() => _PopularRestaurantShimmerState();
}

class _PopularRestaurantShimmerState extends State<PopularRestaurantShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, left: 10, right: 10),
                child: Card(
                  //shadowColor: Colors.grey,
                  elevation: 1,
                  // shadowColor: Colors.blueGrey,
                  margin: EdgeInsets.all(2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(2)),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: <Widget>[
                      Shimmer.fromColors(
                        child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0),
                        child: ListTile(
                          //  leading:CircleAvatar(backgroundImage:AssetImage("assets/images/pizza_hut") ,) ,
                          title: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Text(
                                'Popular Restaurant Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "Popular Restaurant Description",
                                  style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Text(
                                  "Popular Restaurant Address",
                                  style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: RatingBar.builder(
                                      itemSize: 20,
                                      initialRating:
                                      4.9,
                                      minRating: 1,
                                      direction:
                                      Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder:
                                          (context, _) =>
                                          Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                          ),
                                      onRatingUpdate:
                                          (rating) {
                                        
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        left: 10.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                      child: Text(
                                        "(0)  reviews",
                                        style: TextStyle(
                                            color:
                                            Colors.grey
                                        ),
                                      ),
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
              );
            }),
      ),
    );
  }
}
