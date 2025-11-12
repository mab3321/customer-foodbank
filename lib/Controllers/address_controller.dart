import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/services/api-list.dart';
import '/services/server.dart';
import '../models/address_model.dart';
import '../screens/main_screen.dart';
import '../views/checkout_page.dart';

class AddressController extends GetxController {
  Server server = Server();
  List<AddressData> address = <AddressData>[];
  bool searchLoader = true;
  String addressName = '';
  String addressLabelName = '';
  String addressLat = '';
  String addressLong = '';
  String addressCurrentLat = '';
  String addressCurrentLong = '';
  String addressCurrent = '';

  @override
  void onInit() async {
    getAddress();
    getAddressLabelValue();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAddress() async {
    server.getRequest(endPoint: APIList.address).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        var addressData = AddressModel.fromJson(jsonResponse);
        address = <AddressData>[];
        address.addAll(addressData.data!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }

  getAddressLabelValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressLabelName = prefs.getString('addressLabel')!;
    addressName = prefs.getString('address')!;
    addressLat = prefs.getString('addressLate')!;
    addressLong = prefs.getString('addressLong')!;
    addressCurrentLat = prefs.getString('addressCurrentLat')!;
    addressCurrentLong = prefs.getString('addressCurrentLong')!;
    addressCurrent = prefs.getString('addressCurrent')!;
    update();
  }

  addCurrentAddress(address, lat, long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('addressCurrent', address.toString());
    prefs.setString('addressLabel', 'current');
    prefs.setString('address', address.toString());
    prefs.setString('addressLate', lat.toString());
    prefs.setString('addressLong', long.toString());
    prefs.setString('addressCurrentLat', lat.toString());
    prefs.setString('addressCurrentLong', long.toString());
    addressCurrentLat = prefs.getString('addressCurrentLat')!;
    addressCurrentLong = prefs.getString('addressCurrentLong')!;
    addressCurrent = prefs.getString('addressCurrent')!;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  addAddress(addressLabel, address, lat, long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('address', address.toString());
    prefs.setString('addressLabel', addressLabel.toString());
    prefs.setString('addressLate', lat.toString());
    prefs.setString('addressLong', long.toString());
    addressLabelName = prefs.getString('addressLabel')!;
    addressName = prefs.getString('address')!;
    addressLat = prefs.getString('addressLate')!;
    addressLong = prefs.getString('addressLong')!;
    addressCurrentLat = prefs.getString('addressCurrentLat')!;
    addressCurrentLong = prefs.getString('addressCurrentLong')!;
    addressCurrent = prefs.getString('addressCurrent')!;
    update();
  }

  postAddress(lat, long, label, labelName, addressName, apartment) {
    var uniqueLabel = true;
    getAddress();
    address.forEach((element) {
      if (label.toString() == element.label &&
          labelName.toString() == element.labelName) {
        uniqueLabel = false;
      }
    });
    if (uniqueLabel) {
      Map body = {
        'label': int.parse(label.toString()),
        'label_name': label == 5
            ? 'Home'
            : label == 10
                ? 'Work'
                : labelName,
        'lat': lat,
        'long': long,
        'new_address': addressName,
        'apartment': apartment,
      };
      String jsonBody = json.encode(body);
      server
          .postRequestWithToken(endPoint: APIList.addressStore, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          addAddress(labelName, addressName, lat, long);
          Get.rawSnackbar(
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP,
              message: jsonResponse['data']['message'].toString());
          Get.off(() => MainScreen());
        } else if (response != null && response.statusCode == 422) {
        } else {
          Get.rawSnackbar(message: 'Please enter valid input');
        }
      });
      update();
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.orange,
          snackPosition: SnackPosition.TOP,
          message: 'This Label is already used!');
    }
  }

  updateAddress(id, lat, long, label, labelName, addressName, apartment) {
    var uniqueLabel = true;
    getAddress();
    address.forEach((element) {
      if (label.toString() == element.label &&
          labelName.toString() == element.labelName) {
        if (element.id.toString() != id.toString()) {
          uniqueLabel = false;
        }
      }
    });
    if (uniqueLabel) {
      Map body = {
        'label': int.parse(label.toString()),
        'label_name': label == 5
            ? 'Home'
            : label == 10
                ? 'Work'
                : labelName,
        'lat': lat,
        'long': long,
        'new_address': addressName,
        'apartment': apartment,
      };
      String jsonBody = json.encode(body);
      server
          .putRequest(
              endPoint: APIList.addressUpdate! + id.toString(), body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          addAddress(labelName, addressName, lat, long);
          Get.rawSnackbar(
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP,
              message: jsonResponse['data']['message'].toString());
          Get.off(CheckoutPage());
        } else if (response != null && response.statusCode == 422) {
          // if (jsonResponse['message']['name'] != null) {
          //   Get.rawSnackbar(message: jsonResponse['message']['name'].toString());
          // }
        } else {
          Get.rawSnackbar(message: 'Please enter valid input');
        }
      });
      update();
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.orange,
          snackPosition: SnackPosition.TOP,
          message: 'This Label is already used!');
    }
  }

  addressDelete(id) {
    server
        .deleteRequest(endPoint: APIList.addressDelete! + id.toString())
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Get.rawSnackbar(
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: jsonResponse['data']['message'].toString());
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
    update();
  }
}
