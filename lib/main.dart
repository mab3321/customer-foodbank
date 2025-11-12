import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ex/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import '/widgets/authentication.dart';
import 'package:get/get.dart';
import 'Controllers/global-controller.dart';
import 'translation/language.dart';

final box = GetStorage();
dynamic langValue = const Locale('en', null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  if (box.read('languageCode') != null) {
    langValue = Locale(box.read('languageCode'), null);
  } else {
    langValue = const Locale('en', null);
  }
  runApp(FoodEx());
}

class FoodEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put(GlobalController()).onInit();
    return OverlaySupport(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodbank Customer',
        locale: langValue,
        translations: Languages(),
        theme: ThemeData(
          useMaterial3: false,
          primaryColor: Colors.black87.withOpacity(1.0),
        ),
        home: Authentication(),
      ),
    );
  }
}
