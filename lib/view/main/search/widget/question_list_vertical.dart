import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:dr_alshaal/view/main/search/widget/question_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../utils/widgets/loader.dart';
import '../view_model/search_view_model.dart';

class QuestionListVertical extends StatefulWidget {
  const QuestionListVertical({Key? key}) : super(key: key);

  @override
  State<QuestionListVertical> createState() => _QuestionListVerticalState();
}

class _QuestionListVerticalState extends State<QuestionListVertical> {
  final SearchViewModel searchViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الأسئلة والأستشارات',
                style: TextStyle(
                    color: DesignColors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        Obx(
          () => Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchViewModel.itemSearch?.questions?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                  height: 20,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      QuestionViewModel questionViewModel = Get.find();
                      questionViewModel.selectedQuestion =
                          searchViewModel.itemSearch!.questions![index];
                      Get.toNamed(AppRoutes.questionDetails,
                          arguments: ['main']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: QuestionCard(
                          question:
                              searchViewModel.itemSearch!.questions![index]),
                    )),
              ),
              searchViewModel.getPaginationLoading
                  ? const SizedBox(
                      height: 100,
                      child: Loader(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
