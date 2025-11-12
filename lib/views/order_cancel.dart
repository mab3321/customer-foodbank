import 'package:flutter/material.dart';
import '/Controllers/order_cancel_controller.dart';
import '/screens/main_screen.dart';
import 'package:get/get.dart';

class OrderCancelPage extends StatelessWidget {
  final id;
  OrderCancelPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderCancelController>(
      init: OrderCancelController(id),
      builder: (response) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.cancel, color: Colors.white)),
                SizedBox(height: 20),
                response.message == null
                    ? Text('YOUR_ORDER_HAS_BEEN_CANCELED'.tr)
                    : Text('${response.message.toString()}',
                        style: TextStyle(color: Colors.black)),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => Get.off(() => MainScreen()),
                    child: Text('Go to main')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
