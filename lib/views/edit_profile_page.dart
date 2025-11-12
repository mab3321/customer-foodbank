import 'dart:io';
import 'package:flutter/material.dart';
import '/Controllers/profile_controller.dart';
import '/services/validators.dart';
import '/utils/size_config.dart';
import '/utils/theme_colors.dart';
import '/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  Validators validators = Validators();
  final profileController = ProfileController();
  var mainHeight, mainWidth;
  File? _image;

  @override
  void initState() {
    profileController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
      });
    }

    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profile) => Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text('EDIT_PROFILE'.tr),
        ),
        body: SingleChildScrollView(
            child: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Color(0xff476cfb),
                child: ClipOval(
                  child: new SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: (_image != null)
                        ? Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            profile.image!,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  //image picker
                  getImage();
                },
                icon: Icon(
                  Icons.camera,
                  size: 30,
                  color: ThemeColors.baseThemeColor,
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 10),
                height: mainHeight / 1.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors.baseThemeColor.withOpacity(.01),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NAME*'.tr),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: profile.nameController
                            ..text = profile.name!
                            ..selection = TextSelection.collapsed(
                                offset: profile.nameController.text.length),
                          obscureText: false,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 0.8,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                          ),
                          validator: (value) {
                            profile.name = value!.trim();

                            return;
                          },
                          onChanged: (value) {
                            profile.name = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('EMAIL*'),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: profile.emailController
                            ..text = profile.email!
                            ..selection = TextSelection.collapsed(
                                offset: profile.emailController.text.length),
                          obscureText: false,
                          //initialValue: widget.userdata['name'],
                          textAlign: TextAlign.start,
                          autofocus: false,

                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: 18,
                            height: 0.8,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            // hintText: "${profile.email}",
                          ),
                          validator: (value) {
                            profile.email = value!.trim();
                            return;
                          },
                          onChanged: (value) {
                            profile.email = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('PHONE_NO*'.tr),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: profile.phoneController
                            ..text = profile.phone!
                            ..selection = TextSelection.collapsed(
                                offset: profile.phoneController.text.length),
                          obscureText: false,
                          //initialValue: widget.userdata['name'],
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 18,
                            height: 0.8,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade700),
                            ),
                          ),
                          validator: (value) {
                            profile.phone = value!.trim();
                            return;
                          },
                          onChanged: (value) {
                            profile.phone = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('ADDRESS*'.tr),
                        SizedBox(
                          height: 5,
                        ),
                        profile.address == null
                            ? TextFormField(
                                controller: profile.addressController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 0.8,
                                ),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                ),
                                validator: (value) {
                                  profile.address = value!.trim();
                                  return;
                                },
                                onChanged: (value) {
                                  profile.address = value;
                                },
                              )
                            : TextFormField(
                                controller: profile.addressController
                                  ..text = profile.address!
                                  ..selection = TextSelection.collapsed(
                                      offset: profile
                                          .addressController.text.length),
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 0.8,
                                ),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade700),
                                  ),
                                ),
                                validator: (value) {
                                  profile.address = value!.trim();
                                  return;
                                },
                                onChanged: (value) {
                                  profile.address = value;
                                },
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: SizedBox(
                              width: 130,
                              height: 40,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeColors.baseThemeColor,
                                ),
                                icon: Icon(
                                  Icons.update,
                                  size: 26,
                                ),
                                label: Text(
                                  'UPDATE'.tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  if (_image == null) {
                                    profile.updateUserProfile(
                                        context: context,
                                        filepath: profile.image!,
                                        type: false);
                                  } else {
                                    profile.updateUserProfile(
                                        context: context,
                                        filepath: _image!.path,
                                        type: true);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          profile.loader
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: Center(
                      child: Loader(),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ])),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ThemeColors.baseThemeColor;
    Path path = Path()
      ..relativeLineTo(0, 115)
      ..quadraticBezierTo(size.width / 2, 250, size.width, 115)
      ..relativeLineTo(0, -115)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
