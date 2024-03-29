import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
  required Color color,
  required IconData icon,
}) {
  var snackBar = SnackBar(
    duration: Duration(milliseconds: 1500),
    elevation: 0,
    shape: RoundedRectangleBorder(),
    content: Center(
      child: Container(
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        width: double.maxFinite - 20,
        height: 55,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
            ),
            title: Text(
              text,
              style: TextStyle(
                  fontSize: 12, color: Colors.white, fontFamily: 'Cairo'),
            ),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
