import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

buildSection({required String title, required Function onTap, required String icon, GlobalKey? key}) {
  return InkWell(
    onTap: () => onTap.call(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          SvgPicture.asset(
            key: key,
            icon,
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DesignColors.brown),
          )
        ],
      ),
    ),
  );
}
