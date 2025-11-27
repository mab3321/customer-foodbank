import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'arabic.dart';
import 'urdu.dart';
import 'english.dart';
import 'french.dart';
import 'german.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': english,
    'ur': urdu,
    'de': german,
    'fr': french,
    'ar': arabic,
  };
}
