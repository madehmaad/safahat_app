import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/env.dart';
import '../../../../models/notification/notification.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          FancyShimmerImage(
            imageUrl: notification.imageThumbnail == null ? '' : Env.baseMediaUrl + notification.imageThumbnail,
            width: 100,
            height: 100,
            boxFit: BoxFit.cover,
            errorWidget: Container(
              color: Colors.grey[100],
              child: Image.asset(
                ImageAssets.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: DesignColors.brown),
                ),
                Text(
                  notification.shortBody ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DesignColors.black),
                ),
                Text(
                  notification.createdDate ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DesignColors.gray2),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
