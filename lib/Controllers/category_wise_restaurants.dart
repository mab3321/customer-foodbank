import 'dart:convert';
import '/models/restaurants_by_category.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CategoryWiseRestaurants extends GetxController {
  Server server = Server();
  var categoryId;
  bool categoryWiseRestaurantsLoader = true;
  List<Restaurant> restaurantList = <Restaurant>[];

  CategoryWiseRestaurants(this.categoryId);

  @override
  void onInit() {
    // this.categoryId;
    getAllRestaurantsByCategory(categoryId);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllRestaurantsByCategory(var id) async {
    server.getRequestWithParam(categoryId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        categoryWiseRestaurantsLoader = false;
        final jsonResponse = json.decode(response.body);
        var categoryWiseRestaurantData =
            RestaurantByCategoryData.fromJson(jsonResponse['data']);
        restaurantList = <Restaurant>[];
        restaurantList.addAll(categoryWiseRestaurantData.data!.restaurants!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}
