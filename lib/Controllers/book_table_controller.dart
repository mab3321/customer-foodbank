import 'dart:convert';
import 'package:flutter/material.dart';
import '/models/profile_model.dart';
import '/models/time_slot.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import '/views/confirmation_page.dart';
import 'package:get/get.dart';

import 'global-controller.dart';

class BookTableController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? userID;

  bool profileLoader = true;
  bool commonLoader = false;
  bool dataLoader = false;

  String? name, email, phone;
  List<TimeSlotList> timeSlotList = <TimeSlotList>[];

  @override
  void onInit() {
    commonLoader = true;
    userID = Get.find<GlobalController>().userId;
    getUserProfile(userId: userID!);
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    super.onInit();
  }

  getUserProfile({String? userId}) {
    commonLoader = false;
    server.getRequest(endPoint: APIList.profile).then((response) {
      if (response != null && response.statusCode == 200) {
        profileLoader = false;
        final jsonResponse = json.decode(response.body);
        var profileData = Profile.fromJson(jsonResponse);
        name = profileData.data!.data!.name;
        email = profileData.data!.data!.email;
        phone = profileData.data!.data!.phone;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  tabelBook(date, timeSlot, guestNo, restaurantId) {
    commonLoader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'restaurant_id': restaurantId,
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'reservation_date': date,
      'guest': guestNo,
      'time_slot': int.parse(timeSlot),
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.reservationBook, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Get.off(ConfirmationPage(jsonResponse['data']['data']));
        emailController.clear();
        nameController.clear();
        phoneController.clear();
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['message']['name'] != null) {
          Get.rawSnackbar(message: jsonResponse['message']['name'].toString());
        } else if (jsonResponse['message']['email'] != null) {
          Get.rawSnackbar(message: jsonResponse['message']['email'].toString());
        } else if (jsonResponse['message']['phone'] != null) {
          Get.rawSnackbar(message: jsonResponse['message']['phone'].toString());
        } else if (jsonResponse['message']['reservation_date'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['reservation_date'].toString());
        } else if (jsonResponse['message']['guest'] != null) {
          Get.rawSnackbar(message: jsonResponse['message']['guest'].toString());
        } else if (jsonResponse['message']['time_slot'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['time_slot'].toString());
        }
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  getTimeSlot(date, guestNo, restaurantId) async {
    dataLoader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'date': date,
      'restaurant_id': restaurantId,
      'capacity': guestNo,
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(
            endPoint: APIList.reservationCheck, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var timeSlotData = TimeSlot.fromJson(jsonResponse);
        timeSlotList = <TimeSlotList>[];
        timeSlotList.add(TimeSlotList(
            id: 0, startTime: 'Change Start time', endTime: 'End time'));
        timeSlotList.addAll(timeSlotData.data!.data!);
        dataLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        dataLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
