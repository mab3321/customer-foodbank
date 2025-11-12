import 'dart:convert';

import '/models/menu_item_model.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class MenuItemController extends GetxController {
  Server server = Server();

  var menuItemId;
  bool lodar = true;
  String? menuItemName,
      menuItemPrice,
      menuItemDiscount,
      menuItemImage,
      menuItemDescription;
  List<Variations> variationList = <Variations>[];
  List<Options> optionList = <Options>[];

  MenuItemController(this.menuItemId);

  @override
  void onInit() {
    getMenuItem(menuItemId);
    super.onInit();
  }

  getMenuItem(var id) async {
    server.getRequestWithParamMenuItems(menuItemId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var menuItemData = MenuItemData.fromJson(jsonResponse["data"]);
        variationList = <Variations>[];
        variationList.addAll(menuItemData.data!.variations!);
        optionList = <Options>[];
        optionList.addAll(menuItemData.data!.options!);
        menuItemId = menuItemData.data!.id!;
        menuItemName = menuItemData.data!.name!;
        menuItemPrice = menuItemData.data!.unitPrice!;
        menuItemDiscount = menuItemData.data!.discountPrice!;
        menuItemImage = menuItemData.data!.image!;
        menuItemDescription = menuItemData.data!.description;
        lodar = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
}
