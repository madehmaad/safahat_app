import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/domain/Service/yourPages/your_pages_service.dart';
import 'package:pages_app/core/domain/model/page_data.dart';

class yourPages extends StatefulWidget {
  const yourPages({super.key});

  @override
  State<yourPages> createState() => _yourPagesState();
}

class _yourPagesState extends State<yourPages> {
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
                      child: textBlack18Bold('الصفحات المسمعة من قبلك'),
                    ),
                  ],
                ),
              ),
            ),
            RefreshIndicator(
                onRefresh: () async {
                  await YourPagesService().getYourPages();
                  setState(() {});
                },
                color: Themecolor,
                child: (yourpagesList.isEmpty)
                    ? FutureBuilder(
                        future: YourPagesService().getYourPages(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width / 1,
                                height: MediaQuery.sizeOf(context).height / 1.7,
                                child: ListView.builder(
                                  itemCount: 7,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return shimmercontainer();
                                  },
                                  // separatorBuilder:
                                  //     (BuildContext context, int index) {
                                  //   return Divider();
                                  // },
                                ),
                              ),
                            );
                          } else if (snap.data is List<PageDataModel>) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                1.6,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Color.fromARGB(60, 0, 0, 0)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: textDinar16LightBlack(
                                                'عدد الصفحات المسمعة')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  5,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            gradient:
                                                LinearGradient(colors: grad),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    60, 0, 0, 0)),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                              child: textDinar18Light(
                                                  yourpagesList.length
                                                      .toString())),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width / 1,
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              1.9,
                                      child: ListView.builder(
                                        itemCount: yourpagesList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return yourpagesScreen(
                                              context,
                                              yourpagesList,
                                              (yourpagesList.length -
                                                  1 -
                                                  index));
                                        },
                                        // separatorBuilder:
                                        //     (BuildContext context, int index) {
                                        //   return Divider();
                                        // },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height / 2,
                              child: Center(
                                  child: Text(
                                      'لا يوجد اتصال بالإنترنت الرجاء المحاولة لاحقاً..')),
                            );
                          }
                        })
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width / 1.6,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(60, 0, 0, 0)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: textDinar16LightBlack(
                                          'عدد الصفحات المسمعة')),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width / 5,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: grad),
                                      border: Border.all(
                                          color: Color.fromARGB(60, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: textDinar18Light(
                                            yourpagesList.length.toString())),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width / 1,
                                height: MediaQuery.sizeOf(context).height / 1.9,
                                child: ListView.builder(
                                  itemCount: yourpagesList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return yourpagesScreen(
                                        context,
                                        yourpagesList,
                                        (yourpagesList.length - 1 - index));
                                  },
                                  // separatorBuilder:
                                  //     (BuildContext context, int index) {
                                  //   return Divider();
                                  // },
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Widget shimmercontainer() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height / 200,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1,
        height: MediaQuery.sizeOf(context).height / 7.5,
        decoration: BoxDecoration(
            color: Color.fromARGB(168, 161, 161, 161),
            borderRadius: BorderRadius.circular(20)),
      ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          delay: 500.ms,
          duration: 1000.ms,
          color: Color.fromARGB(255, 255, 255, 255)),
    );
  }

  Widget yourpagesScreen(
      BuildContext context, List<PageDataModel> list, int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height / 200,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1,
        height: MediaQuery.sizeOf(context).height / 7.5,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grad,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  width: MediaQuery.sizeOf(context).width / 10,
                  height: MediaQuery.sizeOf(context).height / 25,
                  child: Image.asset(
                    'assets/ملف شخصي.png',
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: textDinar17Light(list[index].full_name),
                ),
              ]),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 10,
                        height: MediaQuery.sizeOf(context).height / 30,
                        child: Image.asset(
                          'assets/ايكون رقم الصفحة.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    textDinar15Light(
                        'الصفحة رقم ${list[index].page.toString()}'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 2.5,
                height: MediaQuery.sizeOf(context).height / 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 10,
                      height: MediaQuery.sizeOf(context).height / 35,
                      child: Image.asset(
                        'assets/ايكون التاريخ.png',
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: textDinar15Light(list[index].listen_date),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
