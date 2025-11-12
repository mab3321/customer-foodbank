import 'package:flutter/material.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/views/no_overview_found_page.dart';
import 'package:get/get.dart';

class OverViewPage extends StatelessWidget {
  OverViewPage({Key? key}) : super(key: key);

  final restaurantDetailsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RestaurantDetailsController>(
            init: RestaurantDetailsController(),
            builder: (overview) => overview.restaurantDescription == null
                ? NoOverviewFoundPage()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      '${overview.restaurantDescription}',
                      style: TextStyle(fontSize: 15),
                    ),
                  )));
  }
}
