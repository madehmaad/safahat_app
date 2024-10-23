import 'package:flutter_svg/svg.dart';

import '../../../models/topic/topic.dart';
import '../../../resources/assets_manager.dart';

getTopicIcon(Topic topic) {
  if (topic.id == 1) {
    return SvgPicture.asset(
      ImageAssets.family,
      width: 20,
      height: 20,
    );
  }
  if (topic.id == 2) {
    return SvgPicture.asset(
      ImageAssets.souk,
      width: 20,
      height: 20,
    );
  }
  if (topic.id == 3) {
    return SvgPicture.asset(
      ImageAssets.daua,
      width: 20,
      height: 20,
    );
  }
}
