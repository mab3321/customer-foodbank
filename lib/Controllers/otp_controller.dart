import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import '../services/otp_service.dart';
import '../services/server.dart';
import '../services/user-service.dart';
import '../views/verify_email_page.dart';
import 'global-controller.dart';

class OtpController extends GetxController {
  late EmailAuth emailAuth;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;
  UserService userService = UserService();

  // send otp
  void sendOTP(email) async {
    isLoading = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var otp = await OtpService.otpSend(email: email);
    if (otp) {
      isLoading = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Get.off(() => VerifyEmailPage(email: email));
    } else {
      isLoading = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
    }
  }

  //validate otp
  void verifyOTP(otpCode, email) async {
    isLoading = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var loginData = await OtpService.otpVerify(otp: otpCode);
    if (loginData.token != null) {
      var bearerToken = 'Bearer ' + "${loginData.token}";
      userService.saveBoolean(key: 'is-user', value: true);
      userService.saveString(key: 'token', value: loginData.token);
      userService.saveString(
          key: 'user-id', value: loginData.data!.id.toString());
      userService.saveString(
          key: 'email', value: loginData.data!.email.toString());
      userService.saveString(
          key: 'username', value: loginData.data!.username.toString());
      userService.saveString(
          key: 'image', value: loginData.data!.image.toString());
      userService.saveString(
          key: 'name', value: loginData.data!.name.toString());
      userService.saveString(
          key: 'phone', value: loginData.data!.phone.toString());
      userService.saveString(
          key: 'status', value: loginData.data!.status.toString());
      Server.initClass(token: bearerToken);
      Get.put(GlobalController()).initController();
      codeController.clear();
      isLoading = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Get.off(() => MainScreen());
    } else {
      isLoading = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
    }
  }
}
