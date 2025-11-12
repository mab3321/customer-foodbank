import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/global-controller.dart';
import '../../utils/theme_colors.dart';
import '../models/restaurant_details.dart';

// ignore: must_be_immutable
class PromoText extends StatelessWidget {
  PromoText({Key? key, required this.voucher}) : super(key: key);

  Vouchers voucher;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 5, bottom: 10),
      width: double.infinity,
      color: ThemeColors.baseThemeColor.withOpacity(0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'VOUCHER:'.tr,
                style: textTheme.displayLarge?.copyWith(fontSize: 16),
              ),
              Text(
                voucher.slug.toString(),
                style: TextStyle(
                  color: ThemeColors.baseThemeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'USE_VOUCHER'.tr +
                voucher.slug.toString() +
                'AND_GET'.tr +
                voucher.amount.toString() +
                Get.find<GlobalController>().currencyCode.toString() +
                'OFF_ON_ORDERS_OVER'.tr +
                voucher.minimumOrderAmount.toString() +
                Get.find<GlobalController>().currencyCode.toString(),
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
