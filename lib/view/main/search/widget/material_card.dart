import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/shared_widget/topic%20_icon.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  final MaterialModel materialModel;
  const MaterialCard({Key? key, required this.materialModel}) : super(key: key);

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
                  imageUrl: '${Env.baseMediaUrl}${materialModel.mainImage}' ?? '',
                  width: double.infinity,
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          materialModel.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: DesignColors.brown),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    thickDivider(verticalPadding: 5),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          materialModel.shortDescription ?? "",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: DesignColors.brown),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
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
