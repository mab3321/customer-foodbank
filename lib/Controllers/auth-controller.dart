import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_ex/views/sign_In.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/refresh_token.dart';
import '/models/reg_api.dart';
import '/models/login_api.dart';
import '/screens/main_screen.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import '/services/validators.dart';
import 'package:get/get.dart';

import 'global-controller.dart';

class AuthController extends GetxController {
  UserService userService = UserService();
  Validators _validators = Validators();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  bool obscureText = true;
  bool loader = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late GoogleSignInAccount _userObj;

  changeVisibility() {
    obscureText = !obscureText;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  loginOnTap({BuildContext? context, String? email, String? pass}) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var emailValidator = _validators.validateEmail(value: email);
    var passValidator = _validators.validatePassword(value: pass);
    if (emailValidator == null && passValidator == null) {
      Map body = {'email': email, 'password': pass};
      String jsonBody = json.encode(body);
      server.postRequest(endPoint: APIList.login, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 200) {
          updateFcmSubscribe(email);
          final jsonResponse = json.decode(response.body);
          var loginData = LoginApi.fromJson(jsonResponse);
          var bearerToken = 'Bearer ' + "${loginData.token}";
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: loginData.token);
          userService.saveString(
            key: 'user-id',
            value: loginData.data!.id.toString(),
          );
          userService.saveString(
            key: 'email',
            value: loginData.data!.email.toString(),
          );
          userService.saveString(
            key: 'username',
            value: loginData.data!.username.toString(),
          );
          userService.saveString(
            key: 'image',
            value: loginData.data!.image.toString(),
          );
          userService.saveString(
            key: 'name',
            value: loginData.data!.name.toString(),
          );
          userService.saveString(
            key: 'phone',
            value: loginData.data!.phone.toString(),
          );
          userService.saveString(
            key: 'status',
            value: loginData.data!.status.toString(),
          );
          Server.initClass(token: bearerToken);
          Get.put(GlobalController()).initController();
          emailController.clear();
          passwordController.clear();
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.off(() => MainScreen());
        } else {
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.rawSnackbar(
            message: 'Please enter valid email address and password',
          );
        }
      });
    } else {
      loader = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Get.rawSnackbar(message: 'Please enter email address and password');
    }
  }

  refreshToken() async {
    try {
      server.getRequest(endPoint: APIList.refreshToken).then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var refreshData = RefreshToken.fromJson(jsonResponse);
          var newToken = 'Bearer ' + "${refreshData.token}";
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: refreshData.token);
          Server.initClass(token: newToken);
          Get.put(GlobalController()).initController();
          Get.off(() => MainScreen());
          return true;
        } else {
          Get.off(() => LoginPage());
        }
      });
    } catch (e) {
      Get.off(() => LoginPage());
    }
  }

  signupOnTap({
    BuildContext? context,
    String? name,
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
  }) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var emailValidator = _validators.validateEmail(value: email);
    var passValidator = _validators.validatePassword(value: password);
    if (emailValidator == null && passValidator == null) {
      Map body = {
        'name': name,
        'username': username,
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'password_confirmation': confirmPassword,
        'role': 2,
      };
      String jsonBody = json.encode(body);

      server.postRequest(endPoint: APIList.register, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          var regData = RegApi.fromJson(jsonResponse);
          var bearerToken = 'Bearer ' + "${regData.token}";
          Get.off(() => MainScreen());
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: regData.token);
          userService.saveString(
            key: 'user-id',
            value: regData.data!.id.toString(),
          );
          userService.saveString(
            key: 'email',
            value: regData.data!.email.toString(),
          );
          userService.saveString(
            key: 'username',
            value: regData.data!.username.toString(),
          );
          userService.saveString(
            key: 'image',
            value: regData.data!.image.toString(),
          );
          userService.saveString(
            key: 'name',
            value: regData.data!.name.toString(),
          );
          userService.saveString(
            key: 'phone',
            value: regData.data!.phone.toString(),
          );
          userService.saveString(
            key: 'status',
            value: regData.data!.status.toString(),
          );
          Server.initClass(token: bearerToken);
          Get.put(GlobalController()).initController();
          emailController.clear();
          passwordController.clear();
          nameController.clear();
          usernameController.clear();
          phoneController.clear();
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.off(() => MainScreen());
        } else {
          final jsonResponse = json.decode(response.body);
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          if (jsonResponse['message']['email'][0] != null) {
            Get.rawSnackbar(
              message: jsonResponse['message']['email'][0].toString(),
            );
          }
        }
      });
    }
  }

  updateFcmSubscribe(email) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    Map body = {"device_token": deviceToken, "topic": email};
    String jsonBody = json.encode(body);
    server.postRequest(endPoint: APIList.fcmSubscribe, body: jsonBody).then((
      response,
    ) {
      if (response != null && response.statusCode == 200) {}
    });
  }

  loginFB() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      ); // by default we request the email and the public profile

      if (result.status == LoginStatus.success) {
        // you are logged
        final userData = await FacebookAuth.i.getUserData();
        socialLogin(
          userData['name'].toString(),
          userData['email'].toString(),
          'facebook',
          userData['id'],
        );
      }
    } catch (e) {
      print(e);
    }
  }

  loginGoogle() async {
    try {
      _userObj = (await _googleSignIn.signIn())!;
      print(_userObj);
      socialLogin(
        _userObj.displayName?.toString(),
        _userObj.email.toString(),
        'google',
        _userObj.id.toString(),
      );
    } catch (e) {
      print(e);
    }
  }

  socialLogin(String? name, String? email, String? provider, providerID) async {
    Map body = {
      'name': name,
      'email': email,
      'provider': provider,
      'provider_id': providerID,
      'role': 2,
    };
    String jsonBody = json.encode(body);
    server.postRequest(endPoint: APIList.socialLogin, body: jsonBody).then((
      response,
    ) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var regData = RegApi.fromJson(jsonResponse);
        var bearerToken = 'Bearer ' + "${regData.token}";
        userService.saveBoolean(key: 'is-user', value: true);
        userService.saveString(key: 'token', value: regData.token);
        userService.saveString(
          key: 'user-id',
          value: regData.data!.id.toString(),
        );
        userService.saveString(
          key: 'email',
          value: regData.data!.email.toString(),
        );
        updateFcmSubscribe(regData.data!.email.toString());

        userService.saveString(
          key: 'username',
          value: regData.data!.username.toString(),
        );
        userService.saveString(
          key: 'image',
          value: regData.data!.image.toString(),
        );
        userService.saveString(
          key: 'name',
          value: regData.data!.name.toString(),
        );
        userService.saveString(
          key: 'phone',
          value: regData.data!.phone.toString(),
        );
        userService.saveString(
          key: 'status',
          value: regData.data!.status.toString(),
        );
        Server.initClass(token: bearerToken);
        Get.put(GlobalController()).initController();
        Get.off(() => MainScreen());
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
