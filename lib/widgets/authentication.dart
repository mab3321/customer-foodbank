import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Controllers/auth-controller.dart';
import '/services/user-service.dart';
import '/utils/image.dart';
import '/utils/theme_colors.dart';
import '/views/sign_In.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  UserService userService = UserService();

  AuthController _authController = AuthController();
  var mainHeight, mainWidth;

  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.instance.getToken().then((token) {
      update(token!);
    });
    Timer(
      Duration(seconds: 5),
      () {
        logInCheck();
      },
    );
    super.initState();
  }

  update(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('deviceToken', token);
    print(token);
  }

  logInCheck() async {
    var isUser = await userService.getBool();
    if (isUser == true) {
      await _authController.refreshToken();
    } else {
      Get.off(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: mainHeight,
        width: mainWidth,
        color: ThemeColors.baseThemeColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.splashImage, height: 230, width: 230),
              SizedBox(height: 10),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
