import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../buttons/customized_filled_button.dart';
import '../buttons/customized_outlined_button.dart';

class LogoutConfirmDialog extends StatefulWidget {
  const LogoutConfirmDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutConfirmDialog> createState() => _LogoutConfirmDialogState();
}

class _LogoutConfirmDialogState extends State<LogoutConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 41),
      backgroundColor: DesignColors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Logout',
              textAlign: TextAlign.center,
              style: TextStyle(color: DesignColors.black, fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14.0),
            const Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: TextStyle(color: DesignColors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomizedFilledButton(
                  loading: loading,
                  text: 'Yes',
                  function: () async {},
                ),
                CustomizedOutlinedButton(
                  text: 'No',
                  function: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool loading = false;

  startLoading() {
    setState(() {
      loading = true;
    });
  }

  stopLoading() {
    setState(() {
      loading = false;
    });
  }
}
