import 'dart:io';

import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentViewModel extends GetxController with ManagementController {
  late WebViewController controller;
  late String url;
  late String path;

  loadNetworkDocument() async {
    setMainLoading(true);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            status = true;
          },
          onPageFinished: (String url) {
            setMainLoading(false);
          },
          onWebResourceError: (WebResourceError error) {
            status = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  loadLocalDocument() async {
    final String pathToIndex = await _prepareLocalFile();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFile(pathToIndex);
  }

  Future<String> _prepareLocalFile() async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(<String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    var file = File(path);
    String text = await file.readAsString();
    await indexFile.writeAsString(text);
    return indexFile.path;
  }
}
