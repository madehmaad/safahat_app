import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/shared_widget/topic%20_icon.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/functions.dart';

class MaterialsCard extends StatelessWidget {
  final MaterialModel materialModel;
  const MaterialsCard({Key? key, required this.materialModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: FancyShimmerImage(
                  imageUrl:
                      '${Env.baseMediaUrl}${materialModel.mainImage}' ?? '',
                  boxFit: BoxFit.fitHeight,
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
              SizedBox(
                height: isTablet() ? 50 : null,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    materialModel.title,
                    textAlign: TextAlign.center,
                    overflow: isTablet() ? TextOverflow.ellipsis : null,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: DesignColors.brown),
                  ),
                ),
              ),
              if (materialModel.shortDescription != null || isTablet())
                thickDivider(verticalPadding: 5),
              if (materialModel.shortDescription != null || isTablet())
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: isTablet() ? 50 : null,
                    child: Text(
                      materialModel.shortDescription,
                      textAlign: TextAlign.center,
                      overflow: isTablet() ? TextOverflow.ellipsis : null,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: DesignColors.brown),
                    ),
                  ),
                )
            ],
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
