import 'package:dr_alshaal/view/main/document_viewer/view_model/document_viewer_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentNetworkViewerScreen extends StatelessWidget {
  DocumentNetworkViewerScreen({Key? key}) : super(key: key);
  final DocumentViewModel documentViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        title: 'عرض الملف',
        backIcon: true,
      ),
      body: Obx(
        () => documentViewModel.getMainLoading
            ? const FullLoader()
            : !documentViewModel.status
                ? ErrorScreen(refresh: () => documentViewModel.loadNetworkDocument())
                : WebViewWidget(
                    controller: documentViewModel.controller,
                  ),
      ),
    );
  }
}
