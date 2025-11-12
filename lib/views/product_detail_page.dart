import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '/Controllers/cart_controller.dart';
import '/Controllers/menu_item_controller.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '/views/cart.dart';
import '/widgets/products_description.dart';
import '/widgets/shimmer/product_details_shimmer.dart';

class ProductsDetails extends StatefulWidget {
  final restaurantID, deliveryCharge, menuItemID;

  ProductsDetails({
    required this.restaurantID,
    required this.deliveryCharge,
    required this.menuItemID,
  });

  @override
  _ProductsDetailsState createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  var mainHeight, mainWidth;
  var cartValue = 1;
  var itemCount = 1;
  var variationSelect = 0;
  var optionSelect = 0;
  String selectVaration = '';
  bool? initValue = false;
  final cartController = Get.put(CartController());
  TextEditingController instructionsController = TextEditingController();
  List selectCategories = [];
  List selectOptions = [];

  @override
  void initState() {
    if (cartController.cart.length == 0) {
      setState(() {
        cartController.totalQunty = 0;
      });
    }
    super.initState();
  }

  void incrementCert() {
    setState(() {
      cartValue++;
    });
    itemCount = cartValue;
  }

  void decrementCert() {
    cartValue > 1
        ? setState(() {
            cartValue--;
          })
        : cartValue = 1;
    itemCount = cartValue;
  }

  void _onCategorySelected(bool? selected, categoryId, options) {
    if (selected == true) {
      setState(() {
        print(options);
        selectCategories.add(categoryId);
        selectOptions.add(options);
        print(selectOptions.length);
      });
    } else {
      setState(() {
        selectOptions.removeWhere((item) => item.id == categoryId);
        selectCategories.remove(categoryId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<MenuItemController>(
        init: MenuItemController(widget.menuItemID),
        builder: (menuItem) => menuItem.lodar
            ? ProductsDetailsShimmer()
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  bottomNavigationBar: Container(
                    height: 100,
                    child: _addToCert(menuItem),
                    color: Colors.white,
                  ),
                  floatingActionButton: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GetBuilder<CartController>(
                              init: CartController(),
                              builder: (cart) => Stack(children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        heroTag: null,
                                        elevation: 5,
                                        onPressed: () {
                                          Get.to(() => CartPage());
                                        },
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        backgroundColor:
                                            ThemeColors.baseThemeColor,
                                      ),
                                    )),
                                new Stack(
                                  children: <Widget>[
                                    new Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.orange),
                                    new Positioned(
                                        top: 4.0,
                                        right: 5.5,
                                        child: new Center(
                                          child: new Text(
                                            cart.totalQunty.toString(),
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        )),
                                  ],
                                ),
                              ]),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 30),
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: FittedBox(
                              child: FloatingActionButton(
                                heroTag: null,
                                elevation: 5,
                                backgroundColor: ThemeColors.baseThemeColor,
                                onPressed: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endTop,
                  body: menuItem.lodar == true
                      ? Container()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 32,
                                width: mainWidth,
                                color: ThemeColors.baseThemeColor,
                              ),
                              CachedNetworkImage(
                                imageUrl: menuItem.menuItemImage!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: mainHeight / 4,
                                  width: mainWidth,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: 15, top: 30),
                                    height: mainHeight / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(2.0),
                                          topRight: Radius.circular(2.0)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Description(description: menuItem),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  menuItem.variationList.isEmpty
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "VARIATION".tr,
                                                style: TextStyle(
                                                    fontSize: FontSize.xMedium,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              Text(
                                                '1REQUIRED'.tr,
                                                style: TextStyle(
                                                  fontSize: FontSize.small,
                                                  fontWeight: FontWeight.w900,
                                                  color: ThemeColors
                                                      .baseThemeColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  _chooseVariation(menuItem),
                                  menuItem.optionList.isEmpty
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "OPTIONS".tr,
                                                style: TextStyle(
                                                    fontSize: FontSize.xMedium,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: FontSize.small,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.lightBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  _chooseOption(menuItem),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "SPECIAL_INSTRUCTIONS".tr,
                                      style: TextStyle(
                                          fontSize: FontSize.xMedium,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                        "PLEASE_LET_US_KNOW_IF_YOU_ARE_ALLERGIC_TO_SOMETHING_OR_IF_WE_NEED_TO_AVOID_ANYTHING"
                                            .tr,
                                        style: TextStyle(
                                          fontSize: FontSize.xMedium,
                                          color: Colors.grey,
                                          //fontWeight: FontWeight.w300
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      height: mainHeight / 5,
                                      child: TextFormField(
                                        controller: instructionsController,
                                        minLines: 2,
                                        maxLines: 5,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText:
                                              'WRITE_ANY_MORE_PREFERENCES'.tr,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ));
  }

  _chooseVariation(menuItem) => menuItem.variationList.length == 0
      ? Container()
      : Container(
          height: mainHeight / 3.5,
          child: ListView.builder(
              itemCount: menuItem.variationList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: ThemeColors.baseThemeColor,
                              value: index,
                              groupValue: variationSelect,
                              onChanged: (int? value) {
                                setState(() {
                                  variationSelect = value!;
                                  menuItem.menuItemPrice =
                                      menuItem.variationList[index].unitPrice;
                                  int id = Get.find<CartController>()
                                      .cart
                                      .indexWhere(
                                          (i) => i.id == menuItem.menuItemId);
                                  if (id != -1) {
                                    Get.find<CartController>().removeProduct(
                                        Get.find<CartController>().cart[id].id);
                                  }
                                  selectVaration = menuItem
                                      .variationList[index].id
                                      .toString();
                                });
                              },
                            ),
                            Text(
                              '${menuItem.variationList[index].name}',
                              // style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : shrineBrown900),
                            ),
                          ],
                        ),
                        Text(
                            "${menuItem.variationList[index].currencyCode}${menuItem.variationList[index].unitPrice}"),
                      ],
                    ),
                  )),
        );

  _chooseOption(menuItem) => menuItem.optionList.length == 0
      ? Container()
      : Container(
          height: mainHeight / 3.5,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: false,
            itemCount: menuItem.optionList.length,
            itemBuilder: (context, index) => CheckboxListTile(
              activeColor: ThemeColors.baseThemeColor,
              controlAffinity: ListTileControlAffinity.leading,
              value: selectCategories.contains(menuItem.optionList[index].id),
              onChanged: (bool? selected) {
                _onCategorySelected(selected, menuItem.optionList[index].id,
                    menuItem.optionList[index]);
                print(menuItem.optionList[index]);
              },
              title: Text(menuItem.optionList[index].name.toString()),
              secondary: Text(
                  "${menuItem.optionList[index].currencyCode}${menuItem.optionList[index].price}"),
            ),
          ),
        );

  _addToCert(menuItem) => Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: decrementCert,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '$cartValue',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: incrementCert,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: ThemeColors.baseThemeColor,
                ),
              ],
            ),
            Container(
              height: 40,
              width: mainWidth / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.baseThemeColor, // background
                  foregroundColor: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () async {
                  double total = 0;
                  if (selectOptions.isNotEmpty) {
                    selectOptions.map((element) {
                      total = (total + double.parse(element.price));
                    }).toList();
                  }
                  setState(() {
                    cartController.addProduct(
                      menuItem,
                      menuItem.menuItemId,
                      (double.parse(menuItem.menuItemPrice) + total).toString(),
                      instructionsController.text.trim(),
                      itemCount,
                      widget.restaurantID,
                      widget.deliveryCharge,
                      selectOptions,
                      selectVaration,
                    );
                  });
                  Fluttertoast.showToast(
                    msg: 'ITEM_ADDED_TO_YOUR_CART'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: Text(
                  'ADD_TO_CART'.tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
}
