import 'package:dr_alshaal/view/main/document_viewer/view_model/document_viewer_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentLocalViewerScreen extends StatelessWidget {
  DocumentLocalViewerScreen({Key? key}) : super(key: key);
  final DocumentViewModel documentViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCustom(
          title: 'عرض الملف',
          backIcon: true,
        ),
        body: WebViewWidget(
          controller: documentViewModel.controller,
        ));
  }
}
