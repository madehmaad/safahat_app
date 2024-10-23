import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';

class PostCard extends StatelessWidget {
  final MaterialModel materialModel;
  const PostCard({Key? key, required this.materialModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FancyShimmerImage(
                imageUrl: materialModel.mainImage == null
                    ? ''
                    : Env.baseMediaUrl + materialModel.mainImage,
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
            const SizedBox(
              height: 10,
            ),
            Text(
              materialModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: DesignColors.brown),
            )
          ],
        ),
      ),
    );
  }
}
