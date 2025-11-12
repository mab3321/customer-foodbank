// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ex/utils/theme_colors.dart';

import 'package:get/get.dart';

import '../Controllers/otp_controller.dart';
import '../constants/constant.dart';
import '../widgets/loader.dart';

class VerifyEmailPage extends StatefulWidget {
  String email;
  VerifyEmailPage({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late final TextEditingController codeController;
  OtpController otpController = Get.put(OtpController());
  bool _isButtonActive = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    codeController = OtpController().codeController;
    codeController.addListener(() {
      final _isButtonActive = codeController.text.isNotEmpty;
      setState(() {
        this._isButtonActive = _isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  //OTP pattern input validation
  String? validateOTP(String? value) {
    String pattern = "[0-9]";

    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'ENTER_DIGIT_ONLY'.tr;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'VERIFY_OTP'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: ThemeColors.baseThemeColor,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          "A_TEXT_MESSAGE_WITH".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706881),
                          ),
                        ),
                        Text(
                          "JUST_SEND_TO_YOUR_EMAIL".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706881),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "ENTER_CODE".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                            Text(
                              "*",
                              style:
                                  TextStyle(color: ThemeColors.baseThemeColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 68,
                          child: TextFormField(
                            controller: codeController,
                            textInputAction: TextInputAction.done,
                            validator: (value) => validateOTP(value),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor: ThemeColors.baseThemeColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 0,
                                left: 15,
                              ),
                              fillColor: const Color(0xffF2CDD4),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffF2CDD4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.baseThemeColor,
                        surfaceTintColor:
                            ThemeColors.baseThemeColor, // background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: _isButtonActive
                          ? () {
                              setState(() {
                                _isButtonActive = false;
                                //codeController.clear();
                              });
                              if (_formKey.currentState!.validate()) {
                                otpController.verifyOTP(
                                    codeController.text.trim(), widget.email);
                              } else {}
                            }
                          : null,
                      child: Text(
                        'VERIFY'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      GetBuilder<OtpController>(
                        init: otpController,
                        builder: (loader) {
                          return loader.isLoading
                              ? Positioned(
                                  child: Container(
                                      height: ScreenSize(context).mainWidth,
                                      width: ScreenSize(context).mainWidth,
                                      color: Colors.white60,
                                      child: Center(child: Loader())),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
