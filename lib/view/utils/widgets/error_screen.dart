import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/colors.dart';

class ErrorScreen extends StatelessWidget {
  final Function refresh;
  const ErrorScreen({Key? key, required this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.3,
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              ImageAssets.splash,
              height: 200,
              width: 200,
            ),
          ),
          const Spacer(),
          Center(
              child: InkWell(
            onTap: () {
              refresh.call();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('لا يوجد اتصال بالأنترنت'.tr,
                    style: const TextStyle(
                        fontSize: 18, color: DesignColors.gray2),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 5,
                ),
                Text('حاول مرة أخرى'.tr,
                    style: const TextStyle(
                        fontSize: 18, color: DesignColors.gray2),
                    textAlign: TextAlign.center),
                const Icon(Icons.refresh, color: DesignColors.gray2)
              ],
            ),
          )),
          const Spacer(),
        ],
      ),
    );
  }
}
