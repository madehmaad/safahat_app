// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Students.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';
import 'package:pages_app/views/Done_Pages/bloc/done_pages_bloc.dart';
import 'package:pages_app/views/StudentPages/Student_Pages.dart';

String name = '';
TextEditingController studentname = TextEditingController();
TextEditingController frompage = TextEditingController();
TextEditingController topage = TextEditingController();
TextEditingController studentId = TextEditingController();
TextEditingController studentGroup = TextEditingController();

class DonePagesScreen extends StatefulWidget {
  const DonePagesScreen({super.key});

  @override
  State<DonePagesScreen> createState() => _DonePagesScreenState();
}

class _DonePagesScreenState extends State<DonePagesScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => DonePagesBloc(),
        child: Scaffold(
          body: BlocConsumer<DonePagesBloc, DonePagesState>(
            listener: (context, state) {
              if (state is SuccessDonePage) {
                showSnackBar(
                  context: context,
                  text: 'تم إدخال الصفحات بنجاح',
                  color: Colors.green,
                  icon: Icons.check_circle_outline,
                );
              } else if (state is ExceptionDonePage) {
                showSnackBar(
                  context: context,
                  text: 'حدث خطأ...  تأكد من اتصالك بالإنترنت',
                  color: Colors.red,
                  icon: Icons.wifi_off_outlined,
                );
              } else if (state is ErrorDonePage) {
                showSnackBar(
                  context: context,
                  text: 'حدث خطأ...  يرجى المحاولة مرة أخرى',
                  color: Colors.red,
                  icon: Icons.error_outline_outlined,
                );
              } else {
                showSnackBar(
                  context: context,
                  text: 'حدث خطأ...  يرجى المحاولة مرة أخرى',
                  color: Colors.red,
                  icon: Icons.error_outline_outlined,
                );
              }
            },
            builder: (context, state) {
              return RefreshIndicator(
                color: Themecolor,
                onRefresh: () async {
                  await StudentsService().getStudents();
                  setState(() {});
                },
                child: ListView(children: [
                  Column(
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
                                        image: AssetImage(
                                            'assets/زخرفة كاملة.png'),
                                        fit: BoxFit.cover)),
                                height: MediaQuery.sizeOf(context).height / 3.5,
                                width: MediaQuery.sizeOf(context).width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.sizeOf(context)
                                                  .height /
                                              50),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                10,
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
                                        top: MediaQuery.sizeOf(context).height /
                                            25,
                                      ),
                                      child: textBlack20BoldLight(
                                          'الصفحات المسمعة'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    right: MediaQuery.sizeOf(context).width /
                                        1.15),
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
                          (Studentsnames.isEmpty)
                              ? datanames(context, state)
                              : NameListWidget(context, state),
                        ],
                      ),
                    ],
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget search(List<String> reg, String label,
      TextEditingController controller, List<StudentModel> choosenGroup) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(127, 255, 255, 255)),
      width: screenWidth / 1.5,
      height: screenHeight / 15,
      child: Autocomplete<String>(
        optionsMaxHeight: screenHeight / 3,
        optionsBuilder: (TextEditingValue Searched) {
          // if user is input nothing
          if (Searched.text == '') {
            return const Iterable<String>.empty();
          }
          // if user is input something the build
          // suggestion based on the user input
          Students.where((element) {
            return false;
          });
          return reg.where((String option) {
            return option.contains(Searched.text.toLowerCase());
          });
        },

        // when user click on the suggested
        // item this function calls
        onSelected: (
          String value,
        ) {
          StudentModel studentModel =
              Students.where((element) => element.name == value).first;
          print(studentModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentPagesScreen(
                studentModel: studentModel,
              ),
            ),
          );
        },
        optionsViewBuilder: (context, Function(String) onSelected, options) {
          return Align(
              alignment: Alignment.topLeft,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(0.0)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromARGB(161, 217, 215, 215),
                        border:
                            Border.all(color: Color.fromARGB(134, 83, 82, 82)),
                      ),
                      height: 45.0 * options.length,
                      width: screenWidth / 1.5, // <-- Right here !
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        shrinkWrap: false,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return InkWell(
                              onTap: () => onSelected(option),
                              child: Container(
                                color: Colors.transparent,
                                height: screenHeight / 17,
                                child: Center(
                                    child: Text(
                                  option,
                                  style: TextStyle(
                                      color: Color.fromARGB(185, 76, 76, 76),
                                      fontSize: 18,
                                      fontFamily: 'Cairo'),
                                )),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.grey,
                          );
                        },
                      ),
                    )),
              ));
        },
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          return SizedBox(
            height: screenHeight / 15,
            width: screenWidth / 1.3,
            child: Center(
              child: TextField(
                cursorHeight: screenHeight / 25,
                controller: controller,
                focusNode: focusNode,
                onEditingComplete: onFieldSubmitted,
                cursorColor: Themecolor,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Dinar', color: Themecolor),
                decoration: InputDecoration(
                  label: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      label,
                      style:
                          TextStyle(color: Color.fromARGB(167, 147, 146, 146)),
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(colors: grad)),
                    height: screenHeight / 15,
                    width: screenWidth / 10,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget datanames(BuildContext context, DonePagesState state) {
    return FutureBuilder(
        future: StudentsService().getStudents(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Center(
                child: const CupertinoActivityIndicator(
                    color: Themecolor, radius: 25),
              ),
            );
          } else if (snap.data is List<StudentModel>) {
            return NameListWidget(context, state);
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

  late String choosenGroup = '';
  Widget NameListWidget(BuildContext context, DonePagesState state) {
    List<StudentModel> groupFilterStudents =
        Students.where((Students) => Students.group == choosenGroup).toList();
    List<String> filternames = List.generate(
        groupFilterStudents.length, (index) => groupFilterStudents[index].name);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height / 70,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(127, 255, 255, 255)),
            width: MediaQuery.sizeOf(context).width / 1.5,
            height: MediaQuery.sizeOf(context).height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: DropdownButtonHideUnderline(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: DropdownButton(
                        alignment: AlignmentDirectional.center,
                        value: (choosenGroup != '') ? choosenGroup : null,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Color.fromARGB(251, 119, 119, 119),
                        ),
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: LinearGradient(colors: grad)),
                          height: MediaQuery.sizeOf(context).height / 15,
                          width: MediaQuery.sizeOf(context).width / 10,
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        items:
                            Studentsgroups.toSet().toList().map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Center(child: Text(items))),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            choosenGroup = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
            child: search(
                filternames, 'اسم الطالب', studentname, groupFilterStudents),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.99,
            height: MediaQuery.sizeOf(context).height * 0.522,
            child: ListView.builder(
                itemCount: groupFilterStudents.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(colors: grad),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentPagesScreen(
                                studentModel: groupFilterStudents[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            width: MediaQuery.sizeOf(context).width / 10,
                            height: MediaQuery.sizeOf(context).height / 25,
                            child: Image.asset(
                              'assets/ملف شخصي.png',
                              color: Colors.white,
                            ),
                          ),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          title: textDinar18Light(
                            groupFilterStudents[index].name,
                          ),
                          // leading: Text(groupFilterStudents[index].group),
                          subtitle: Text(
                            groupFilterStudents[index].id,
                            style: TextStyle(
                                color: Color.fromARGB(193, 203, 202, 202),
                                fontFamily: 'Cairo'),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
