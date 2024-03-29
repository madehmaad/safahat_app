import 'package:flutter/material.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';

Widget sectionConrainer(
  BuildContext context,
  String title,
  String image,
) {
  return Container(
    width: MediaQuery.sizeOf(context).width / 1.1,
    height: MediaQuery.sizeOf(context).height / 7,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          colors: grad,
        ),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          leading: Container(
            width: 50,
            height: 30,
            child: Image.asset('assets/' + image),
          ),
          title: textDinar17Light(title),
        ),
        Divider(
          color: Colors.white,
          thickness: 3,
          endIndent: 20,
          indent: 20,
        )
      ],
    ),
  );
}
