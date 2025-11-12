import 'dart:convert';
import '/models/search.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Server server = Server();
  List<Restaurant> restaurantList = <Restaurant>[];
  bool searchLoader = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSearch(name, expedition) async {
    searchLoader = true;
    Map<String, String> queryParameters = {
      'name': name,
      'expedition': expedition == 'dine-in' ? 'table' : expedition,
    };
    server
        .getRequestParam(endPoint: APIList.search, body: queryParameters)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        searchLoader = false;
        final jsonResponse = json.decode(response.body);
        var searchData = Data.fromJson(jsonResponse['data']);
        restaurantList = <Restaurant>[];
        restaurantList.addAll(searchData.data!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}
