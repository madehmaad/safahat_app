import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';

class AhadethDetails extends StatefulWidget {
  final String? path;
  const AhadethDetails({Key? key, required this.path}) : super(key: key);

  @override
  State<AhadethDetails> createState() => _AhadethDetailsState();
}

class _AhadethDetailsState extends State<AhadethDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: appBarCustom(title: 'ahadeth'.tr, backIcon: true),
        body: const PDF().cachedFromUrl(
          widget.path!,
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ));
  }
}
