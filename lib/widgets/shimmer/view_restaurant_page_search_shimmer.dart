import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class ViewRestaurantPageSearchShimmer extends StatefulWidget {
  const ViewRestaurantPageSearchShimmer({Key? key}) : super(key: key);

  @override
  _ViewRestaurantPageSearchShimmerState createState() => _ViewRestaurantPageSearchShimmerState();
}

class _ViewRestaurantPageSearchShimmerState extends State<ViewRestaurantPageSearchShimmer> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: mainHeight,
        width: mainWidth,
        color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return
              Padding(
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
                      //add image
                      Shimmer.fromColors(
                        child: Container(
                            height: 130,
                            width: mainWidth,
                            color: Colors.grey),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0),
                        child: ListTile(
                          title: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5),
                              child: Text(
                                'McDonalds',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey
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
                                  'Costly foods',
                                  style:
                                  TextStyle(fontSize: 13),
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
                                  'USA',
                                  style:
                                  TextStyle(fontSize: 13),
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 8,
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
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 10.0),
                                      child: Text(
                                        "(122)  reviews",
                                        style: TextStyle(
                                            color:
                                            Colors.grey),
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
          },
        ),
      ),
    );
  }
}
