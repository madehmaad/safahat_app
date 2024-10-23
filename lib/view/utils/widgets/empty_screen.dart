import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/colors.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  const EmptyScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
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
              child: Text(title,
                  style: const TextStyle(fontSize: 18, color: DesignColors.gray2), textAlign: TextAlign.center)),
          const Spacer(),
        ],
      ),
    );
  }
}
