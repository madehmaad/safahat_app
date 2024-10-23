import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  const AuthButton({Key? key, required this.text, required this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 11.0),
        decoration: BoxDecoration(color: color ?? DesignColors.primary, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: DesignColors.white, fontSize: 22.0, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
