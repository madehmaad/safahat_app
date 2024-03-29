import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/Dialog.dart';
import 'package:pages_app/core/Config/widgets/SectionContainer.dart';
import 'package:pages_app/views/Admin/AdminPage.dart';
import 'package:pages_app/views/Done_Pages/Done_Pages.dart';
import 'package:pages_app/views/EnterPages/Enter_Pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage> {
  late List<Widget> tiles = [];
  GlobalKey<AnimatedListState> keys = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setData();
    });
  }

  int index = 1;
  setData() {
    var dataList = [
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EnterPagesScreen()));
        },
        child: sectionConrainer(context, 'إدخال الصفحات', 'download.png'),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height / 40,
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DonePagesScreen()));
        },
        child: sectionConrainer(context, 'الصفحات المسمعة', 'quran.png'),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height / 40,
      ),
      InkWell(
        onTap: () {
          (config<SharedPreferences>().getString('TeacherJob') == 'مشرف إداري')
              ? Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AdminPage()))
              : showNoAccessDialog(context: context);
        },
        child: sectionConrainer(context, 'الصفحة الإداريـــة', 'adminpage.png'),
      ),
    ];

    Future temporary = Future(() {});

    dataList.forEach((element) {
      temporary = temporary.then((_) {
        return Future.delayed(Duration(milliseconds: 100), () {
          tiles.add(element);
          keys.currentState!
              .insertItem(index - 1, duration: Duration(milliseconds: 200));
          index++;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Tween<Offset> postion = Tween(begin: Offset(1, 0.5), end: Offset(0, 0.5));
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
                        top: MediaQuery.sizeOf(context).height / 200,
                      ),
                      child: textBlack14Bold('الـصـفـحـة الـرئـيـسـيـة'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height / 350,
                      ),
                      child: textBlack12Bold('أهــلاً وســهـلاً بـكـم'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.7,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    height: MediaQuery.sizeOf(context).height / 1.7,
                    child: AnimatedList(
                      key: keys,
                      initialItemCount: tiles.length,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        return SlideTransition(
                            position: animation.drive(postion),
                            child: tiles[index]);
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
