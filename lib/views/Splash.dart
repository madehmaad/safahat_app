import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/domain/Service/Gsheets/addStudentSheet.dart';
import 'package:pages_app/core/domain/Service/Gsheets/gsheet.dart';
import 'package:pages_app/views/Login/log.dart';
import 'package:pages_app/views/NavigationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(Duration(milliseconds: 2500), () async {
      await UserSheetsApi.init();
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (config.get<SharedPreferences>().getString('TeacherName') ==
                        null)
                    ? logscreen()
                    : NavigationPage(
                        selectedIndex: 0,
                      )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: grad,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                image: DecorationImage(
                    image: AssetImage("assets/زخرفة كاملة.png"),
                    fit: BoxFit.cover)),
            child: Center(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0,
                                bottom:
                                    MediaQuery.sizeOf(context).height / 100),
                            child: textBlack14Bold(
                                'تطبيـــق دورة القــرآن الكريـــم '),
                          )
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(
                                  delay: 700.ms,
                                  duration: 2800.ms,
                                  color: Color.fromARGB(255, 107, 93, 121)),
                          Container(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                            height: MediaQuery.sizeOf(context).height / 7,
                            child: Image.asset(
                              'assets/لوغو.png',
                            ),
                          )
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(
                                  delay: 700.ms,
                                  duration: 2800.ms,
                                  color: Color.fromARGB(255, 107, 93, 121)),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height / 20,
                            ),
                            child: Container(
                                    width: MediaQuery.sizeOf(context).width / 1.3,
                                    height: MediaQuery.sizeOf(context).height / 5,
                                    child: Image.asset(
                                      'assets/لوغو تطبيق.png',
                                    ))
                                .animate(
                                    onPlay: (controller) => controller.repeat())
                                .shimmer(
                                    delay: 700.ms,
                                    duration: 2800.ms,
                                    color: Color.fromARGB(255, 107, 93, 121)),
                          )
                        ])))));
  }
}
