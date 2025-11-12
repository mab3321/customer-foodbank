import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '/models/add_review_request.dart';
import '/models/restaurant_details.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';
import 'global-controller.dart';

class RestaurantDetailsController extends GetxController {
  Server server = Server();

  String? userID;
  int? restaurantID;
  bool restaurantDetailsLoader = true;
  bool? orderStatus;
  int? reviewCount;
  int? rating;
  int? tableStatus;

  List<MenuItemData> menuItemList = <MenuItemData>[];
  List<Review> reviewList = <Review>[];
  List<Vouchers> vouchersList = <Vouchers>[];
  String? restaurantName,
      restaurantDeliveryCharge,
      restaurantDescription,
      restaurantAddress,
      restaurantImage,
      restaurantLogo,
      openingTime,
      closingTime,
      lat,
      long,
      cuisines;
  TextEditingController reviewController = TextEditingController();
  var ratingController;

  @override
  void onInit() {
    userID = Get.find<GlobalController>().userId;
    super.onInit();
  }

  getRestaurant(int id) {
    server.getRequest(endPoint: APIList.restaurant! + id.toString()).then((
      response,
    ) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var restaurantData = RestaurantDetailsData.fromJson(
          jsonResponse['data'],
        );
        if (restaurantData.data!.restaurant!.cuisines!.isNotEmpty) {
          var cuisinesData = '';
          restaurantData.data!.restaurant!.cuisines!.forEach((element) {
            cuisinesData += element['name'].toString() + ', ';
          });
          if (cuisinesData.isNotEmpty && cuisinesData.length > 0) {
            cuisines = cuisinesData.substring(0, cuisinesData.length - 2);
          }
        }

        menuItemList = <MenuItemData>[];
        menuItemList.addAll(restaurantData.data!.menuItems!);
        reviewList = <Review>[];
        reviewList.addAll(restaurantData.data!.reviews!);
        vouchersList = <Vouchers>[];
        vouchersList.addAll(restaurantData.data!.vouchers!);
        reviewCount = restaurantData.data!.countUser;
        rating = restaurantData.data!.avgRating;
        Get.find<CartController>().addRestuarentData(
          restaurantData.data!.restaurant!,
        );
        restaurantID = restaurantData.data!.restaurant!.id;
        tableStatus = restaurantData.data!.restaurant!.tableStatus;
        restaurantName = restaurantData.data!.restaurant!.name;
        restaurantDeliveryCharge =
            restaurantData.data!.restaurant!.deliveryCharge.toString();
        restaurantDescription = restaurantData.data!.restaurant!.description;
        restaurantImage = restaurantData.data!.restaurant!.image;
        restaurantLogo = restaurantData.data!.restaurant!.logo;
        openingTime = restaurantData.data!.restaurant!.openingTime;
        closingTime = restaurantData.data!.restaurant!.closingTime;
        restaurantAddress = restaurantData.data!.restaurant!.address;
        lat = restaurantData.data!.restaurant!.lat;
        long = restaurantData.data!.restaurant!.long!;
        orderStatus = restaurantData.data!.orderStatus!;
        restaurantDetailsLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  addReview({BuildContext? context, addReviewRating, String? review}) async {
    Map body = {
      'rating': addReviewRating,
      'review': review,
      'user_id': int.parse(userID!),
      'restaurant_id': restaurantID,
    };
    String jsonBody = json.encode(body);
    server.postRequestWithToken(endPoint: APIList.review, body: jsonBody).then((
      response,
    ) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var addReviewData = AddReviewRequest.fromJson(jsonResponse);
        print(addReviewData.review);
        reviewController.clear();
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
