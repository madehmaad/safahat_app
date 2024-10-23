import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:dr_alshaal/view/main/question/widget/category_question_card.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dialogs/confirm_dialog.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';

class QuestionCategoryScreen extends StatelessWidget {
  QuestionCategoryScreen({Key? key}) : super(key: key);
  final QuestionViewModel questionViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool status=false;
        await Get.dialog(ConfirmDialog(
          height: 200,
          title: "هل تريد الخروج من التطبيق",
          confirmBtnText: "نعم",
          confirmFunction: ()  {
            status=true;
            Get.back();
          },
          dismissBtnText: "لا",
        ));
        return status;
      },
      child: BaseScaffold(
          appBar: appBarCustom(
              title: 'questions'.tr, menuIcon: true, liveStreamIcon: true, notificationIcon: true, searchIcon: true),
          body: Obx(() => questionViewModel.getMainLoading
              ? const FullLoader()
              : !questionViewModel.status
                  ? ErrorScreen(refresh: () => questionViewModel.getCategories())
                  : Padding(
                      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 0,
                            ),
                            itemCount: questionViewModel.categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: InkWell(
                                  onTap: () {
                                    questionViewModel.selectedId = questionViewModel.categories[index].id;
                                    questionViewModel.getQuestionData();
                                    Get.toNamed(AppRoutes.questionList, arguments: ['main']);
                                  },
                                  child: CategoryQuestionCard(
                                    width: Get.width,
                                    questionCategory: questionViewModel.categories[index],
                                  ),
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    ))),
    );
  }
}
