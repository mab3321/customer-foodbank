import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/Controllers/search_controller.dart' as search;
import '/json/home_page_json.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '/views/restaurant_details.dart';
import '/views/search_error_page.dart';
import '/widgets/shimmer/view_restaurant_page_search_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ViewRestaurantPageSearch extends StatefulWidget {
  final type;
  const ViewRestaurantPageSearch({Key? key, required this.type})
      : super(key: key);

  @override
  _ViewRestaurantPageSearchState createState() =>
      _ViewRestaurantPageSearchState();
}

class _ViewRestaurantPageSearchState extends State<ViewRestaurantPageSearch> {
  final searchController = Get.put(search.SearchController());
  int activeMenu = 0;
  String restaurentName = '';
  TextEditingController searchTextController = TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text(
    'RESTAURANT'.tr,
    style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: FontSize.xLarge,
        color: Colors.white),
  );

  @override
  void initState() {
    activeMenu = widget.type;
    searchController.getSearch('', menu[activeMenu].toLowerCase());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white10,
          child: Column(
            children: [
              //Search bar
              Container(
                padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                child: Row(
                  children: [
                    new SizedBox(
                        height: 22.0,
                        width: 22.0,
                        child: new IconButton(
                          padding: new EdgeInsets.all(0.0),
                          color: ThemeColors.baseThemeColor,
                          icon: new Icon(Icons.arrow_back, size: 25.0),
                          onPressed: () => Get.back(),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.grey.shade200,
                        child: Container(
                          padding: EdgeInsets.only(left: 14),
                          height: 40,
                          child: TextFormField(
                            controller: searchTextController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5),
                              isCollapsed: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "SEARCH_FOR_RESTAURANTS".tr,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {
                                restaurentName = value.toString();
                              });
                              searchController.getSearch(restaurentName,
                                  menu[activeMenu].toLowerCase());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //Restaurant list after search
              GetBuilder<search.SearchController>(
                  init: search.SearchController(),
                  builder: (searchRestaurant) {
                    return Expanded(
                      child: searchRestaurant.searchLoader
                          ? ViewRestaurantPageSearchShimmer()
                          : searchRestaurant.restaurantList.isEmpty
                              ? SearchErrorPage()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      searchRestaurant.restaurantList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(RestaurantDetails(
                                            id: searchRestaurant
                                                .restaurantList[index].id,
                                          ));
                                        },
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
                                              CachedNetworkImage(
                                                imageUrl: searchRestaurant
                                                    .restaurantList[index]
                                                    .image!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4.5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    2.0),
                                                            topRight: Radius
                                                                .circular(2.0)),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                      //alignment: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  child: Container(
                                                      height: 130,
                                                      width: 200,
                                                      color: Colors.grey),
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[400]!,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Text(
                                                      searchRestaurant
                                                          .restaurantList[index]
                                                          .name!,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        searchRestaurant
                                                            .restaurantList[
                                                                index]
                                                            .description!,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        searchRestaurant
                                                            .restaurantList[
                                                                index]
                                                            .address!,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBar.builder(
                                                            itemSize: 20,
                                                            initialRating:
                                                                searchRestaurant
                                                                    .restaurantList[
                                                                        index]
                                                                    .avgRating!
                                                                    .toDouble(),
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color: ThemeColors
                                                                  .baseThemeColor,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              "(${searchRestaurant.restaurantList[index].avgRatingUser!.toInt()})  " +
                                                                  "REVIEWS".tr,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
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
                                  },
                                ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
