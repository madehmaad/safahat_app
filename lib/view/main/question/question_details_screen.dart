import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final bool isSub;

  const QuestionDetailsScreen({Key? key, required this.isSub})
      : super(key: key);

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  late final QuestionViewModel questionViewModel;
  AppController appController = Get.find();
  ScrollController navController = ScrollController();

  @override
  void initState() {
    questionViewModel = Get.find(tag: widget.isSub ? 'sub' : null);
    navController.addListener(() {
      if (navController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (appController.navBarIsVisible.value) {
          appController.navBarIsVisible.value = false;
        }
      }
      if (navController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!appController.navBarIsVisible.value) {
          appController.navBarIsVisible.value = true;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(const Duration(milliseconds: 200),
        () => appController.navBarIsVisible.value = true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCustom(title: 'question'.tr, backIcon: true),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(ImageAssets.placeholderPng),
            fit: BoxFit.fill,
          )),
          child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: SingleChildScrollView(
                controller: navController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      questionViewModel.questions?.title ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: DesignColors.brown),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                  questionViewModel.selectedQuestion?.date)) ??
                              '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${'question_number'.tr} (${questionViewModel.selectedQuestion?.id.toString()})',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionViewModel.selectedQuestion?.title ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: DesignColors.brown),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      questionViewModel.selectedQuestion?.description ?? '',
                      style: const TextStyle(
                          height: 1.7,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: DesignColors.brown),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'answer'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: DesignColors.brown),
                    ),
                    Html(
                      data: questionViewModel.selectedQuestion?.answer ?? '',
                      style: {
                        "span": Style(lineHeight: LineHeight.number(1.7)),
                        "p": Style(lineHeight: LineHeight.number(1.7)),
                      },
                      onLinkTap: (url, Map<String, String> attributes,
                          var element) async {
                        launchUrl(Uri.parse(url!));
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}
