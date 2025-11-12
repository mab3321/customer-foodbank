import 'dart:convert';

import '/models/banner.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  Server server = Server();
  List<BannerData> bannerList = <BannerData>[];

  bool bannerLoader = true;

  @override
  void onInit() {
    getBanners();
    super.onInit();
  }

  getBanners() async {
    server.getRequest(endPoint: APIList.banners).then((response) {
      if (response != null && response.statusCode == 200) {
        bannerLoader = false;
        final jsonResponse = json.decode(response.body);
        var bannerData = Data.fromJson(jsonResponse['data']);
        bannerList = <BannerData>[];
        bannerList.addAll(bannerData.data!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  Future<void> onRefreshScreen() async {
    getBanners();
    update();
    await Future.delayed(new Duration(seconds: 3));
  }
}
