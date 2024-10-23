import 'package:get/get.dart';

import 'arabic.dart';
import 'english.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'ar': Arabic().messages, 'en': English().messages};
}
