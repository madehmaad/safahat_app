import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../../resources/routes.dart';
import '../../question/widget/category_question_card.dart';

class QuestionHomeList extends StatelessWidget {
  QuestionHomeList({Key? key}) : super(key: key);
  final QuestionViewModel questionViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'الأسئلة الشرعية',
            style: TextStyle(fontSize: 20, color: DesignColors.brown, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 10),
              ...questionViewModel.categories
                  .map(
                    (e) => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            questionViewModel.selectedId = e.id;
                            questionViewModel.getQuestionData();
                            Get.toNamed(AppRoutes.questionList, arguments: ['main']);
                          },
                          child: CategoryQuestionCard(
                            width: 350,
                            questionCategory: e,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
