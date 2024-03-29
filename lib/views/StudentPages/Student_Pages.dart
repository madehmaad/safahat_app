// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:pages_app/Icons/my_flutter_app_icons.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/Service/yourPages/your_pages_service.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';
import 'package:pages_app/core/domain/model/page_data.dart';
// import 'package:pages_app/deleteme/more.dart';
import 'package:pages_app/views/StudentPages/bloc/student_pages_bloc.dart';

String studentName = '';

class StudentPagesScreen extends StatefulWidget {
  final StudentModel studentModel;
  StudentPagesScreen({required this.studentModel});

  @override
  State<StudentPagesScreen> createState() => _StudentPagesScreenState();
}

class _StudentPagesScreenState extends State<StudentPagesScreen> {
  @override
  Widget build(BuildContext context) {
    studentName = widget.studentModel.name;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => StudentPagesBloc(),
        child: Scaffold(
          body: BlocConsumer<StudentPagesBloc, StudentPagesState>(
            listener: (context, state) {
              if (state is SuccessStudentPages) {
                showSnackBar(
                  context: context,
                  text: 'تم إدخال الصفحات بنجاح',
                  color: Colors.green,
                  icon: Icons.check_circle_outline,
                );
              } else if (state is ExceptionStudentPages) {
                showSnackBar(
                  context: context,
                  text: 'حدث خطأ...  تأكد من اتصالك بالإنترنت',
                  color: Colors.red,
                  icon: Icons.wifi_off_outlined,
                );
              } else if (state is ErrorStudentPages) {
                showSnackBar(
                  context: context,
                  text: 'حدث خطأ...  يرجى المحاولة مرة أخرى',
                  color: Colors.red,
                  icon: Icons.error_outline_outlined,
                );
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  Column(
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
                                      top: MediaQuery.sizeOf(context).height /
                                          50),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width / 2,
                                    height:
                                        MediaQuery.sizeOf(context).height / 10,
                                    child: Image.asset(
                                      'assets/لوغو تطبيق.png',
                                    )
                                        .animate(
                                            onPlay: (controller) =>
                                                controller.repeat())
                                        .shimmer(
                                            delay: 4000.ms,
                                            duration: 2800.ms,
                                            color: Color.fromARGB(
                                                255, 107, 93, 121)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.sizeOf(context).height / 25,
                                  ),
                                  child: textBlack20BoldLight('صفحات الطالب'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                right: MediaQuery.sizeOf(context).width / 1.15),
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 50),
                        child: (pagesList.isEmpty)
                            ? datanames(context, state)
                            : donePages(context, state),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget datanames(BuildContext context, StudentPagesState state) {
    return FutureBuilder(
        future: YourPagesService().getYourPages(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Center(
                child: const CupertinoActivityIndicator(
                    color: Themecolor, radius: 25),
              ),
            );
          } else if (snap.data is List<PageDataModel>) {
            return donePages(context, state);
          } else {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Center(
                  child:
                      Text('لا يوجد اتصال بالإنترنت الرجاء المحاولة لاحقاً..')),
            );
          }
        });
  }

  Widget donePages(BuildContext context, StudentPagesState state) {
    List<PageDataModel> _listPageDataModel = listPageDataModel
        .where((element) => element.full_name == studentName)
        .toList();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(127, 255, 255, 255)),
          width: MediaQuery.sizeOf(context).width / 1.5,
          height: MediaQuery.sizeOf(context).height / 15,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: LinearGradient(colors: grad)),
                  height: MediaQuery.sizeOf(context).height / 15,
                  width: 45,
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              textBlack13Bold(
                widget.studentModel.name,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(127, 255, 255, 255)),
                width: MediaQuery.sizeOf(context).width / 2.2,
                height: MediaQuery.sizeOf(context).height / 18,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: LinearGradient(colors: grad)),
                          height: MediaQuery.sizeOf(context).height / 18,
                          width: 40,
                          child: Icon(
                            Iconsax.people,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: textBlack13Bold(
                        widget.studentModel.group,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(127, 255, 255, 255)),
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    height: MediaQuery.sizeOf(context).height / 18,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  gradient: LinearGradient(colors: grad)),
                              height: MediaQuery.sizeOf(context).height / 18,
                              width: 40,
                              child: Container(
                                child: Image.asset(
                                  'assets/ايكون رقم الطالب.png',
                                ),
                                width: 10,
                                height: 10,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: textBlack13Bold(
                            widget.studentModel.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.sizeOf(context).width / 80),
                child: Container(
                  child: Center(
                    child: Text(
                      'عدد الصفحات المسمعة',
                      style: TextStyle(
                          color: Color.fromARGB(185, 76, 76, 76),
                          fontSize: 12,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  height: MediaQuery.sizeOf(context).height / 18,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(97, 104, 102, 102)),
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(43, 255, 255, 255)),
                ),
              ),
              Container(
                child: Center(
                  child: textDinar25Light(
                    '${_listPageDataModel.length}',
                  ),
                ),
                width: MediaQuery.sizeOf(context).width / 5,
                height: MediaQuery.sizeOf(context).height / 18,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: grad)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.99,
            height: MediaQuery.sizeOf(context).height * 0.46,
            child: RefreshIndicator(
              color: Themecolor,
              onRefresh: () async {
                await YourPagesService().getYourPages();
                setState(() {});
              },
              child: ListView.builder(
                  itemCount: _listPageDataModel.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: grad),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: MediaQuery.sizeOf(context).width / 10,
                                height: MediaQuery.sizeOf(context).height / 35,
                                child: Image.asset(
                                  'assets/ملف شخصي.png',
                                  color: Colors.white,
                                ),
                              ),
                              textColor: Color.fromARGB(231, 255, 253, 253),
                              iconColor: Colors.white,
                              title: textDinar18Light(
                                  _listPageDataModel[index].listener_name),
                              subtitle: textBlack12Bold(
                                  _listPageDataModel[index].listen_date),
                              trailing: SizedBox(
                                width: 120,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 20,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                20,
                                        child: Image.asset(
                                          'assets/ايكون رقم الصفحة.png',
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: textDinar15Light(
                                          'الصفحة ' +
                                              _listPageDataModel[index]
                                                  .page
                                                  .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        )
      ],
    );
  }
}
