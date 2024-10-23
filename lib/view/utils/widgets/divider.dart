import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';

Widget thinDivider({double horizontalPadding = 0, double verticalPadding = 0}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
    child: const Divider(height: 0, thickness: 0.5, color: DesignColors.gray2),
  );
}

Widget thickDivider({double horizontalPadding = 0, double verticalPadding = 0}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
    child: const Divider(height: 0, thickness: 1, color: DesignColors.gray2),
  );
}
