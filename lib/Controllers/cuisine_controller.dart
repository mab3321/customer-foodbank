import 'dart:convert';
import '/models/cuisine.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CuisineController extends GetxController {
  Server server = Server();
  List<CuisineDataModel> cuisineList = <CuisineDataModel>[];
  bool cuisineLoader = true;

  @override
  void onInit() {
    getAllCuisine();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllCuisine() async {
    server.getRequest(endPoint: APIList.cuisine).then((response) {
      if (response != null && response.statusCode == 200) {
        cuisineLoader = false;
        final jsonResponse = json.decode(response.body);
        var cuisineData = CuisineData.fromJson(jsonResponse['data']);
        cuisineList = <CuisineDataModel>[];
        cuisineList.addAll(cuisineData.cuisineList!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}
