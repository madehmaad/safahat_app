import 'package:dr_alshaal/models/question/question.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: Text(
                    question.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: DesignColors.brown, fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
                thickDivider(verticalPadding: 5),
                SizedBox(
                  height: 40,
                  child: Text(
                    question.description,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: DesignColors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
