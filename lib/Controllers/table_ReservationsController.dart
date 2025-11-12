import 'dart:convert';
import '/models/table_reservations.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class TableReservationsController extends GetxController {
  Server server = Server();
  List<ReservationDatum> reservationsList = <ReservationDatum>[];
  bool tableReservationLoader = true;
  String? restaurantName;

  @override
  void onInit() {
    tableReservationLoader = true;
    getAllReservations();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllReservations() async {
    server.getRequest(endPoint: APIList.reservation).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var reservationData =
            TableReservationData.fromJson(jsonResponse["data"]);
        reservationsList = <ReservationDatum>[];
        reservationsList.addAll(reservationData.data!);
        tableReservationLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }

  changeReservationStatus(status, id) async {
    tableReservationLoader = true;
    var jsonMap = {
      'status': int.parse(status),
    };
    String jsonStr = jsonEncode(jsonMap);
    server
        .putRequest(endPoint: APIList.reservationStatus! + id, body: jsonStr)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        onInit();
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        tableReservationLoader = false;
        Get.rawSnackbar(message: 'Please');
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
}
