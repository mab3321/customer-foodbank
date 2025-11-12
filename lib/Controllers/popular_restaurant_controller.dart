import 'dart:convert';

import '/models/popular_restaurant.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class PopularRestaurantController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  bool popularRestaurantLoader = true;

  List<Datum> bestSellingRestaurantList = <Datum>[];

  @override
  void onInit() {
    popularRestaurantLoader = true;
    getPopularRestaurant();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

    super.onInit();
  }

  getPopularRestaurant() async {
    bestSellingRestaurantList.clear();
    server.getRequest(endPoint: APIList.popularRestaurant).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var popularRestaurantData = Data.fromJson(jsonResponse['data']);
        bestSellingRestaurantList = <Datum>[];
        bestSellingRestaurantList.addAll(popularRestaurantData.data!);
        popularRestaurantLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        popularRestaurantLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
}
