import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:dr_alshaal/view/main/search/widget/question_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../view_model/search_view_model.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final SearchViewModel searchViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الأسئلة والأستشارات',
                  style: TextStyle(color: DesignColors.brown, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                if (searchViewModel.selectedSubject.value?.id != 'questions')
                  InkWell(
                    onTap: () {
                      searchViewModel.searchPagination(Category(id: 'questions'));
                    },
                    child: Container(
                      height: 25,
                      width: 100,
                      decoration: BoxDecoration(
                        color: DesignColors.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'see_more'.tr,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: DesignColors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: searchViewModel.itemSearch?.questions?.length ?? 0,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 0,
                      height: 20,
                    ),
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          QuestionViewModel questionViewModel = Get.find();
                          questionViewModel.selectedQuestion = searchViewModel.itemSearch!.questions![index];
                          Get.toNamed(AppRoutes.questionDetails, arguments: ['main']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: QuestionCard(question: searchViewModel.itemSearch!.questions![index]),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
