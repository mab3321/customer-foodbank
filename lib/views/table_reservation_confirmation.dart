import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableReservationConfirmation extends StatefulWidget {
  const TableReservationConfirmation({Key? key}) : super(key: key);

  @override
  _TableReservationConfirmationState createState() =>
      _TableReservationConfirmationState();
}

class _TableReservationConfirmationState
    extends State<TableReservationConfirmation> {
  var mainHeight, mainWidth;
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        height: mainHeight,
        width: mainWidth,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/table_reservation_icon.png",
                  color: Colors.amber,
                  height: mainHeight / 3,
                  width: mainWidth / 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "THANKS_FOR".tr,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RESERVATIONS".tr,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "WE_ARE_AN_INTERNATIONAL".tr,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  print('Received click');
                },
                child: Center(
                  child: Text('BOOK_MORE_TABLE.'.tr,
                      style: TextStyle(
                          // fontSize: FontSize.medium,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  print('Received click');
                },
                child: Center(
                  child: Text('BOOK_MORE_TABLE.'.tr,
                      style: TextStyle(
                          // fontSize: FontSize.medium,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
