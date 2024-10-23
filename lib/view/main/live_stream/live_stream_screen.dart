import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/live_stream/view_model/live_stream_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({Key? key}) : super(key: key);

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  LiveStreamViewModel liveStreamViewModel = Get.put(LiveStreamViewModel());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'live_stream'.tr,
        backIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Obx(
          () => liveStreamViewModel.getMainLoading
              ? const FullLoader()
              : !liveStreamViewModel.status
                  ? ErrorScreen(
                      refresh: () => liveStreamViewModel.onInit(),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'مكسلر 24/7',
                              style: TextStyle(color: DesignColors.primary, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () async =>
                                  await launchUrl(Uri.parse(liveStreamViewModel.liveStream?.mixler?.redirectLink)),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: DesignColors.primary, borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 120,
                                child: const Center(
                                  child: Text(
                                    'فتح على مكسلر',
                                    style:
                                        TextStyle(color: DesignColors.white, fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(height: 0, thickness: 0.5, color: DesignColors.gray2),
                        ),
                        SizedBox(
                          height: 200,
                          child: WebViewWidget(
                            controller: liveStreamViewModel.mixlerController,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'فيسبوك',
                              style: TextStyle(color: DesignColors.primary, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () async => await launchUrl(
                                  Uri.parse(liveStreamViewModel.liveStream?.facebook?.redirectLink),
                                  mode: LaunchMode.externalNonBrowserApplication),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: DesignColors.primary, borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 120,
                                child: const Center(
                                  child: Text(
                                    'فتح على فيسبوك',
                                    style:
                                        TextStyle(color: DesignColors.white, fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(height: 0, thickness: 0.5, color: DesignColors.gray2),
                        ),
                        SizedBox(
                          height: 200,
                          child: WebViewWidget(
                            controller: liveStreamViewModel.facebookController,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'يوتيوب',
                              style: TextStyle(color: DesignColors.primary, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () async =>
                                  await launchUrl(Uri.parse(liveStreamViewModel.liveStream?.youtube?.redirectLink)),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: DesignColors.primary, borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 120,
                                child: const Center(
                                  child: Text(
                                    'فتح على يوتيوب',
                                    style:
                                        TextStyle(color: DesignColors.white, fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(height: 0, thickness: 0.5, color: DesignColors.gray2),
                        ),
                        SizedBox(
                          height: 300,
                          child: WebViewWidget(

                            controller: liveStreamViewModel.youtubeController,
                          ),
                        ),
                      ]),
                    ),
        ),
      ),
    );
  }
}
