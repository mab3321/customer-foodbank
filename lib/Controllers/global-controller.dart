import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/setting_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import '/views/sign_In.dart';

class GlobalController extends GetxController {
  Server server = Server();
  GoogleSignIn _googleSignIn = GoogleSignIn();

  UserService userService = UserService();
  bool profileLoader = true;
  String? bearerToken,
      siteName,
      customerAppName,
      siteEmail,
      siteLogo,
      customerAppLogo,
      currencyCode,
      currencyName,
      supportNum,
      googleMapApiKey,
      stripeSecret,
      stripeKey,
      paystacKey,
      razorpayKey,
      razorpaySecret;
  bool isUser = false;
  String? userId;
  String? get currency => currencyCode;

  initController() async {
    final validUser = await userService.loginCheck();
    isUser = validUser;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    if (isUser) {
      final token = await userService.getToken();
      final myId = await userService.getUserId();
      bearerToken = token;
      userId = myId;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Server.initClass(token: bearerToken);
    }
  }

  @override
  void onInit() {
    siteSettings();
    initController();
    super.onInit();
  }

  userLogout({BuildContext? context}) async {
    getValue();
    await updateFcmUnSubscribe();
    await userService.removeSharedPreferenceData();
    _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    isUser = false;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Get.off(() => LoginPage());
  }

  updateFcmUnSubscribe() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    Map body = {
      "device_token": deviceToken,
      "topic": null,
    };
    String jsonBody = json.encode(body);
    server
        .postRequest(endPoint: APIList.fcmUnSubscribe, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {

      }
    });
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('token');

    return stringValue;
  }

  siteSettings() async {
    server.getRequestSettings(APIList.setting).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var settingData = SettingData.fromJson(jsonResponse['data']);
        paystacKey = settingData.paystacKey;
        razorpayKey = settingData.razorpayKey;
        razorpaySecret = settingData.razorpaySecret;
        stripeKey = settingData.stripeKey;
        stripeSecret = settingData.stripeSecret;
        googleMapApiKey = settingData.googleMapApiKey;
        currencyCode = settingData.currencyCode;
        currencyName = settingData.currencyName;
        supportNum = settingData.supportPhone;
        siteName = settingData.siteName;
        customerAppName = settingData.customerAppName;
        siteEmail = settingData.siteEmail;
        siteLogo = settingData.siteLogo;
        customerAppLogo = settingData.customerAppLogo;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  updateFCMToken(fcmToken) async {
    Map body = {'device_token': fcmToken};
    String jsonBody = json.encode(body);
    server
        .putRequest(endPoint: APIList.device, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 200) {}
    });
  }
}
