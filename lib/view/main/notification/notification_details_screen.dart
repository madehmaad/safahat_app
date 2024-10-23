import 'package:dr_alshaal/view/main/notification/view_model/notification_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/env.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';

class NotificationDetailsScreen extends StatelessWidget {
  NotificationDetailsScreen({Key? key}) : super(key: key);
  final NotificationViewModel notificationViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: appBarCustom(
          title: 'notification'.tr,
          backIcon: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (notificationViewModel.selectedNotification?.image != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FancyShimmerImage(
                        imageUrl:
                            notificationViewModel.selectedNotification?.image ==
                                    null
                                ? ''
                                : Env.baseMediaUrl +
                                    notificationViewModel
                                        .selectedNotification?.image,
                        boxFit: BoxFit.fill,
                        errorWidget: Container(
                          color: Colors.grey[100],
                          child: Image.asset(
                            ImageAssets.logo,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        notificationViewModel.selectedNotification?.title ?? '',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: DesignColors.brown),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Share.share(
                              "${notificationViewModel.selectedNotification?.title}\n ${notificationViewModel.selectedNotification?.shortBody}");
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 30,
                          color: DesignColors.brown,
                        )),
                  ],
                ),
                thickDivider(verticalPadding: 5),
                Html(
                  data: notificationViewModel.selectedNotification?.body ?? '',
                  onLinkTap: (String? url, Map<String, String> attributes,
                      var element) async {
                    launchUrl(Uri.parse(url!));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
