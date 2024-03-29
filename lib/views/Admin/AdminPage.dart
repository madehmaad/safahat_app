import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/Dialog.dart';
import 'package:pages_app/core/Config/widgets/adminContainer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
      SizedBox(
        height: MediaQuery.sizeOf(context).height / 25,
      ),
      InkWell(
        onTap: () {
          showUseLapDialog(context: context);
          // showModalBottomSheetAddStudent(context: context);
        },
        child: adminConrainer(context, 'إضافة طالب', 'اضافة.png'),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height / 30,
      ),
      InkWell(
        onTap: () {
          showUseLapDialog(context: context);
          // showModalBottomSheetAddTeacher(context: context);
        },
        child: adminConrainer(context, 'إضافة مسّمع', 'اضافة.png'),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height / 30,
      ),
      InkWell(
          onTap: () {
            showUseLapDialog(context: context);
            // showExportDialog(context: context);
          },
          child: adminConrainer(context, 'تصدير إكسل', 'تصدير.png')),
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
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomClipPath1(),
            child: Stack(children: [
              Container(
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
                      child: textBlack18Bold('الــصــفــحـــة الإداريــــــة'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/رجوع.png',
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.7,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    height: MediaQuery.sizeOf(context).height / 1.7,
                    child: Center(
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
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
