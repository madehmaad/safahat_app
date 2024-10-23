import 'package:dr_alshaal/models/question_category/question_category.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/env.dart';
import '../../../../resources/assets_manager.dart';

class CategoryQuestionCard extends StatelessWidget {
  final double width;
  final QuestionCategory questionCategory;

  const CategoryQuestionCard({Key? key, required this.questionCategory, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            FancyShimmerImage(
              imageUrl: questionCategory.mainImage == null ? '' : Env.baseMediaUrl + questionCategory.mainImage,
              width: 100,
              height: 140,
              boxFit: BoxFit.cover,
              errorWidget: Container(
                color: Colors.grey[100],
                child: Image.asset(
                  ImageAssets.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: width - 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Text(
                        questionCategory.title ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: DesignColors.brown),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${questionCategory.questionsCount}  ${'question'.tr}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${questionCategory.subCategoriesCount}  ${'sub_category'.tr} ',
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
