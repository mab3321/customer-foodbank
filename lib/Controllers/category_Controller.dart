import 'dart:convert';
import '/models/category.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Server server = Server();
  List<CategoryDataModel> categoriesList = <CategoryDataModel>[];

  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllCategory() async {
    server.getRequest(endPoint: APIList.category).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var categoryData = CategoryData.fromJson(jsonResponse['data']);
        categoriesList = <CategoryDataModel>[];
        categoriesList.addAll(categoryData.categoriesList!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }

  Future<void> onRefreshScreen() async {
    getAllCategory();
    update();
    await Future.delayed(new Duration(seconds: 3));
  }
}
