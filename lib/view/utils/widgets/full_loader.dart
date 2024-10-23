import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../resources/colors.dart';

class FullLoader extends StatelessWidget {
  final Color? color;
  const FullLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width,
      color: DesignColors.white.withOpacity(0.5),
      child: const Center(
          child: SpinKitCircle(
        color: DesignColors.primary,
      )),
    );
  }
}
