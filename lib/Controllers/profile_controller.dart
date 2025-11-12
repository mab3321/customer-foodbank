import 'dart:convert';
import 'package:flutter/material.dart';
import '/models/profile_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';
import 'global-controller.dart';

class ProfileController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordCurrentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  String? userID;

  bool profileLoader = true;
  bool commonLoader = false;
  bool loader = false;
  String? name, email, username, phone, address, image, credit;
  int? totalReservation, totalOrders;

  @override
  void onInit() {
    userID = Get.find<GlobalController>().userId;
    getUserProfile(userId: userID!);
    super.onInit();
  }

  getUserProfile({String? userId}) {
    server.getRequest(endPoint: APIList.profile).then((response) {
      if (response != null && response.statusCode == 200) {
        profileLoader = false;
        final jsonResponse = json.decode(response.body);
        var profileData = Profile.fromJson(jsonResponse);
        name = profileData.data!.data!.name;
        email = profileData.data!.data!.email;
        address = profileData.data!.data!.address;
        phone = profileData.data!.data!.phone;
        username = profileData.data!.data!.username;
        image = profileData.data!.data!.image;
        credit = profileData.data!.data!.balance;
        totalReservation = profileData.data!.data!.totalReservations;
        totalOrders = profileData.data!.data!.totalOrders;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  updateUserProfile(
      {BuildContext? context, required String filepath, type}) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map<String, String> body = {
      'name': nameController.text,
      'address': addressController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };

    server
        .multipartRequest(
            endPoint: APIList.profileUpdate,
            body: body,
            filepath: filepath,
            type: type)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        emailController.clear();
        nameController.clear();
        addressController.clear();
        phoneController.clear();
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.back();
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  updateUserPassword({BuildContext? context}) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'password_current': passwordCurrentController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmController.text,
    };
    String jsonBody = json.encode(body);
    server
        .putRequest(endPoint: APIList.changePassword, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        Get.back();
        Get.rawSnackbar(message: 'Successfully Updated Password');
        passwordCurrentController.clear();
        passwordController.clear();
        passwordConfirmController.clear();
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['message']['password_current'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['password_current'].toString());
        } else if (jsonResponse['message']['password'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['password'].toString());
        } else if (jsonResponse['message']['password_confirmation'] != null) {
          Get.rawSnackbar(
              message:
                  jsonResponse['message']['password_confirmation'].toString());
        }
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
