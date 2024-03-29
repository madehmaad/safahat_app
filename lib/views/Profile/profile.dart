import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            ClipPath(
              clipper: CustomClipPath1(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: grad),
                    image: DecorationImage(
                        image: AssetImage('assets/زخرفة كاملة.png'),
                        fit: BoxFit.cover)),
                height: MediaQuery.sizeOf(context).height / 3.5,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height / 50),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: MediaQuery.sizeOf(context).height / 10,
                        child: Image.asset(
                          'assets/لوغو تطبيق.png',
                        )
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                                delay: 4000.ms,
                                duration: 2800.ms,
                                color: Color.fromARGB(255, 107, 93, 121)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height / 50,
                      ),
                      child: textBlack18Bold('الــمــلــف الـشــخــصـي'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height / 200,
                  bottom: MediaQuery.sizeOf(context).height / 200),
              child: textDinar17LightBlack('قال رسول الله ﷺ'),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: Center(
                  child: textDinar17Light(
                      '«خَيركُـم مـن تعَّلـمَ القرآنَ وعَّلمُه»')),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: grad)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width / 1.5,
                height: MediaQuery.sizeOf(context).height / 5,
                child: Image.asset('assets/ملف شخصي.png'),
              ),
            ),
            textDinar17LightBlackBold(
                config<SharedPreferences>().getString('TeacherName')!),
            textBlack20Bold(
                config<SharedPreferences>().getString('TeacherJob')!),
          ],
        ),
      ),
    );
  }
}
