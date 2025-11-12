import 'dart:convert';
import '/models/restaurabts_by_cuisine.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CuisineWiseRestaurants extends GetxController {
  Server server = Server();
  var cuisineId;
  bool cuisineWiseRestaurantsLoader = true;
  List<Restaurant> restaurantList = <Restaurant>[];

  CuisineWiseRestaurants(this.cuisineId);
  @override
  void onInit() {
    // this.cuisineId;
    getAllRestaurantsByCuisine(cuisineId);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllRestaurantsByCuisine(var id) async {
    server.getRequestWithParamCuisine(cuisineId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        cuisineWiseRestaurantsLoader = false;
        final jsonResponse = json.decode(response.body);
        var cuisineWiseRestaurantData =
            RestaurantByCuisineData.fromJson(jsonResponse['data']);
        restaurantList = <Restaurant>[];
        restaurantList.addAll(cuisineWiseRestaurantData.data!.restaurants!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}
