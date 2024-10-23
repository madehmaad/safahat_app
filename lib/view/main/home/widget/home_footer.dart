import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: DesignColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap: () async =>
                  await launchUrl(Uri.parse('https://FB.com/DrShaal')),
              child: SvgPicture.asset(
                ImageAssets.facebook,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async =>
                  await launchUrl(Uri.parse('https://Dr-Shaal.com')),
              child: SvgPicture.asset(
                ImageAssets.website,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async => await launchUrl(
                  Uri.parse('https://t.me/drshaal'),
                  mode: LaunchMode.externalApplication),
              child: SvgPicture.asset(
                ImageAssets.telegram,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async =>
                  await launchUrl(Uri.parse('https://Youtube.com/DrShaalTube')),
              child: SvgPicture.asset(
                ImageAssets.youtube,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async =>
                  await launchUrl(Uri.parse('https://drshaal.mixlr.com/')),
              child: SvgPicture.asset(
                ImageAssets.mixler,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async =>
                  await launchUrl(Uri.parse('https://SoundCloud.com/DrShaal')),
              child: SvgPicture.asset(
                ImageAssets.soundcloud,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async => await launchUrl(
                  Uri.parse('https://twitter.com/DrShaal'),
                  mode: LaunchMode.externalApplication),
              child: SvgPicture.asset(
                ImageAssets.twitter,
                height: 27,
                width: 27,
                color: DesignColors.white,
              ),
            )
          ]),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'جميع الحقوق محفوظة موقع الشيخ الطبيب محمد خير الشعال - يمنع المتاجرة بأي مادة بقصد الربح، ويسمح بالنسخ و التوزيع بقصد الدعوة.',
              textAlign: TextAlign.center,
              style: TextStyle(color: DesignColors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
