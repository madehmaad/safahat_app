import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:dr_alshaal/view/main/question/widget/category_question_card.dart';
import 'package:dr_alshaal/view/main/question/widget/question_list_card.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/widgets/error_screen.dart';
import '../../utils/widgets/full_loader.dart';
import '../../utils/widgets/loader.dart';

class QuestionListScreen extends StatefulWidget {
  final bool isSub;

  const QuestionListScreen({Key? key, required this.isSub}) : super(key: key);

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late final QuestionViewModel questionViewModel;

  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (questionViewModel.questions?.questions?.nextPageUrl != null) {
        questionViewModel.getPaginationQuestions();
      }
    }
  }

  @override
  void initState() {
    questionViewModel = Get.find(tag: widget.isSub ? 'sub' : null);
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(title: 'questions'.tr, backIcon: true),
      body: Obx(() => questionViewModel.getActionLoading
          ? const FullLoader()
          : !questionViewModel.statusQuestion
              ? ErrorScreen(refresh: () => questionViewModel.getQuestionData())
              : Padding(
                  padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(ImageAssets.placeholderPng),
                      fit: BoxFit.fill,
                    )),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                questionViewModel.questions?.title ?? '',
                                style: const TextStyle(
                                    color: DesignColors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          if (questionViewModel
                              .questions!.subCategories!.isNotEmpty)
                            Text(
                              'sub_category'.tr,
                              style: const TextStyle(
                                  color: DesignColors.brown,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (questionViewModel
                              .questions!.subCategories!.isNotEmpty)
                            ...questionViewModel.questions!.subCategories!
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      QuestionViewModel questionViewModel =
                                          Get.put(QuestionViewModel(),
                                              tag: 'sub');
                                      questionViewModel.selectedId = e.id;
                                      questionViewModel.getQuestionData();
                                      Get.toNamed(AppRoutes.questionList,
                                          preventDuplicates: false,
                                          arguments: ['sub']);
                                    },
                                    child: CategoryQuestionCard(
                                      width: Get.width,
                                      questionCategory: e,
                                    ),
                                  ),
                                )
                                .toList(),
                          if (questionViewModel
                              .questions!.subCategories!.isNotEmpty)
                            const SizedBox(
                              height: 20,
                            ),
                          if (questionViewModel
                              .questions!.questions!.data.isNotEmpty)
                            Text(
                              'text_question'.tr,
                              style: const TextStyle(
                                  color: DesignColors.brown,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          Obx(
                            () => Column(
                              children: [
                                ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: questionViewModel.questions
                                            ?.questions?.data.length ??
                                        0,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            questionViewModel.selectedQuestion =
                                                questionViewModel.questions!
                                                    .questions!.data[index];
                                            Get.toNamed(
                                                AppRoutes.questionDetails,
                                                arguments: widget.isSub
                                                    ? ['sub']
                                                    : ['main']);
                                          },
                                          child: QuestionListCard(
                                            question: questionViewModel
                                                .questions!
                                                .questions!
                                                .data[index],
                                            isSub: widget.isSub,
                                          ));
                                    }),
                                questionViewModel.getPaginationLoading
                                    ? const SizedBox(
                                        height: 60,
                                        child: Loader(),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
