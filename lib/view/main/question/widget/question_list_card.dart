import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/question/question.dart';
import '../../../../resources/routes.dart';
import '../view_model/question_view_model.dart';

class QuestionListCard extends StatefulWidget {
  final bool isSub;
  final Question question;

  const QuestionListCard({Key? key, required this.question, required this.isSub}) : super(key: key);

  @override
  State<QuestionListCard> createState() => _QuestionListCardState();
}

class _QuestionListCardState extends State<QuestionListCard> {
  late final QuestionViewModel questionViewModel;

  @override
  void initState() {
    questionViewModel = Get.find(tag: widget.isSub ? 'sub' : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.question.id.toString()} - ${widget.question.title}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: DesignColors.primary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.question.description,
            style: const TextStyle(
              height: 1.8,
              fontSize: 16,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              questionViewModel.selectedQuestion = widget.question;
              Get.toNamed(AppRoutes.questionDetails, arguments: widget.isSub ? ['sub'] : ['main']);
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
                  'قراءة المزيد'.tr,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: DesignColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
