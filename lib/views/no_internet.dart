import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off),
            Text(
              'NO_INTERNET'.tr,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
