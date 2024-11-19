import 'package:dr_alshaal/config/functions.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/env.dart';
import '../../../../resources/routes.dart';
import '../../materials/view_model/materials_view_model.dart';
import '../../shared_widget/topic _icon.dart';

class CommonCard extends StatelessWidget {
  final MaterialModel materialModel;

  const CommonCard({Key? key, required this.materialModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 10),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
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
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          materialModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: DesignColors.brown),
                        ),
                      ),
                      thinDivider(verticalPadding: 5),
                      SizedBox(
                        height: 40,
                        child: Text(
                          materialModel.shortDescription ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: DesignColors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                MaterialsViewModel materialsViewModel =
                                    Get.put(MaterialsViewModel());
                                // materialsViewModel.selectedSeriesId =
                                //     materialModel.series?.id;
                                materialsViewModel.selectedSeriesName =
                                    materialModel.series?.title;
                                materialsViewModel.selectedSeriesSlug =
                                    materialModel.series?.slug;
                                materialsViewModel.getAllData();

                                Get.toNamed(AppRoutes.materials);
                              },
                              child: Container(
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: DesignColors.primary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    materialModel.series?.title ??
                                        'go_to_serie'.tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: DesignColors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              getDateLocal(materialModel.materialDate),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: DesignColors.black),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (materialModel.topics!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...materialModel.topics!
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            child: getTopicIcon(e),
                          ))
                      .toList(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
