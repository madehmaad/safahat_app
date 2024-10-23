import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/assets_manager.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(title: 'contact_us'.tr, backIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async =>
                    await launchUrl(Uri.parse('https://Dr-Shaal.com')),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.website,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Dr-Shaal.com',
                        style: TextStyle(
                            fontSize: 18,
                            color: DesignColors.brown,
                            fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async =>
                    await launchUrl(Uri.parse('https://FB.com/DrShaal')),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.facebook,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'FB.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async => await launchUrl(
                    Uri.parse('https://Youtube.com/DrShaalTube')),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.youtube,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'Youtube.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaalTube',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async =>
                    await launchUrl(Uri.parse('https://drshaal.mixlr.com/')),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.mixler,
                      width: 40,
                      height: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'Mixlr.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async => await launchUrl(
                    Uri.parse('https://SoundCloud.com/DrShaal')),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.soundcloud,
                      width: 40,
                      height: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'SoundCloud.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async => await launchUrl(
                    Uri.parse('https://t.me/drshaal'),
                    mode: LaunchMode.externalApplication),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.telegram,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'Telegram.me/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async => await launchUrl(
                    Uri.parse('https://instagram.com/dr_shaal'),
                    mode: LaunchMode.externalApplication),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.instagram,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'instagram.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              thickDivider(verticalPadding: 10),
              InkWell(
                onTap: () async => await launchUrl(
                    Uri.parse('https://twitter.com/DrShaal'),
                    mode: LaunchMode.externalApplication),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.twitter,
                      height: 40,
                      width: 40,
                      color: DesignColors.brown,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RichText(
                            text: const TextSpan(
                                text: 'twitter.com/',
                                style: TextStyle(
                                    fontSize: 18, color: DesignColors.brown),
                                children: [
                              TextSpan(
                                text: 'DrShaal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: DesignColors.brown,
                                    fontWeight: FontWeight.w900),
                              ),
                            ])))
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              // Center(
              //     child: Text(
              //   'share_app'.tr,
              //   style: const TextStyle(fontSize: 18, color: DesignColors.brown),
              // )),
              // const SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Image.asset(ImageAssets.googlePlay),
              //     Image.asset(ImageAssets.appStore),
              //   ],
              // )
            ]),
          ),
        ),
      ),
    );
  }
}
