import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pages_app/core/Config/clipPath.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/Dialog.dart';
import 'package:pages_app/core/Config/widgets/entrycontainer.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Students.dart';
import 'package:pages_app/core/domain/Service/enterPage/enter_page_service.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';
import 'package:pages_app/core/domain/model/entered_page_model.dart';
import 'package:pages_app/views/EnterPages/bloc/enter_page_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name = '';
TextEditingController studentname = TextEditingController();
TextEditingController frompage = TextEditingController();
TextEditingController topage = TextEditingController();
TextEditingController studentId = TextEditingController();
TextEditingController studentGroup = TextEditingController();

class EnterPagesScreen extends StatefulWidget {
  const EnterPagesScreen({super.key});

  @override
  State<EnterPagesScreen> createState() => _EnterPagesScreenState();
}

class _EnterPagesScreenState extends State<EnterPagesScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => enterPageBloc(),
      child: Scaffold(
        body: BlocConsumer<enterPageBloc, enterPageState>(
          listener: (context, state) {
            if (state is SuccessenterPage) {
              showSnackBar(
                context: context,
                text: 'تم إدخال الصفحات بنجاح',
                color: Colors.green,
                icon: Icons.check_circle_outline,
              );
            } else if (state is ExcptionenterPage) {
              showSnackBar(
                context: context,
                text: 'حدث خطأ...  تأكد من اتصالك بالإنترنت',
                color: Colors.red,
                icon: Icons.wifi_off_outlined,
              );
            } else if (state is ErrorenterPage) {
              showSnackBar(
                context: context,
                text: 'حدث خطأ...  يرجى المحاولة مرة أخرى',
                color: Colors.red,
                icon: Icons.error_outline_outlined,
              );
            } else if (state is Donepage) {
              showDublicateDialog(
                context: context,
                message: donepagesList.toString(),
              );
            } else if (state is Blocked) {
              showBlockedDialog(context: context);
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
                                    top:
                                        MediaQuery.sizeOf(context).height / 50),
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
                                  top: MediaQuery.sizeOf(context).height / 50,
                                ),
                                child: textBlack18Bold(
                                    'إدخـــــال الــــصـــفـــحـــات'),
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
                    (Studentsnames.isEmpty)
                        ? datanames(context, state)
                        : enterscreen(context, state),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }

// ?  -----------------------------------------------------------------------------------------------------------
// !  -----------------------------------------------------------------------------------------------------------
//    -----------------------------------------------------------------------------------------------------------
  Widget search(
    List<String> reg,
    String label,
    TextEditingController controller,
  ) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(98, 0, 0, 0)),
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(127, 255, 255, 255)),
      width: screenWidth / 1.3,
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
          return reg.where((String option) {
            return option.contains(Searched.text.toLowerCase());
          });
        },

        // when user click on the suggested
        // item this function calls
        onSelected: (
          String value,
        ) {
          setState(() {
            controller.text = value;
            name = value;
            studentId.text =
                Students.where((element) => element.name == value).first.id;

            studentGroup.text =
                Students.where((element) => element.name == value).first.group;

            // //  ind = reg[ind];
          });
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
                      width: screenWidth / 1.3, // <-- Right here !
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        shrinkWrap: false,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return InkWell(
                              onTap: () => onSelected(option),
                              // child: Padding(
                              //   padding: const EdgeInsets.all(16.0),
                              //   child: Text(option),
                              // ),
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

  Widget datanames(BuildContext context, enterPageState state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder(
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
              return enterscreen(context, state);
            } else {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height / 2,
                child: Center(
                    child: Text(
                        'لا يوجد اتصال بالإنترنت الرجاء المحاولة لاحقاً..')),
              );
            }
          }),
    );
  }

  Widget enterscreen(BuildContext context, enterPageState state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 50),
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                search(Studentsnames, 'اسم الطالب', studentname),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height / 30),
                  child: entryContainer(context, 'اسم الطالب'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: MediaQuery.sizeOf(context).height / 15,
                      child: Center(child: textBlack13Bold(studentname.text)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(94, 209, 205, 205))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    entryContainer(context, 'رقم الطالب'),
                    entryContainer(context, 'الحلقة')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      greycontainer(context, studentId.text),
                      greycontainer(context, studentGroup.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      entryContainer(context, 'من الصفحة'),
                      entryContainer(context, 'إلى الصفحة')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      greyenterpage(context, frompage, form1),
                      greyenterpage(context, topage, form2),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.sizeOf(context).height / 20),
                  child: SizedBox(
                    width: 230,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 117, 21, 226))),
                      child: (state is LoadingToenterPage)
                          ? Center(
                              child: const CupertinoActivityIndicator(
                                  color: Colors.white, radius: 15),
                            )
                          : Center(
                              child: const Text(
                                'تـسـجـيـل الـصـفـحـات',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Cairo'),
                              ),
                            ),
                      onPressed: (state is LoadingToenterPage)
                          ? null
                          : () async {
                              (((form1.currentState?.validate() ?? true) &&
                                          (form2.currentState?.validate() ??
                                              true)) &&
                                      (int.parse(topage.text) >=
                                          int.parse(frompage.text)) &&
                                      (studentname.text.isNotEmpty))
                                  ? context.read<enterPageBloc>().add(enterPage(
                                      page: List.generate(
                                          (int.parse(topage.text) -
                                              int.parse(frompage.text) +
                                              1),
                                          (index) => enteredPage(
                                                  full_name: studentname.text,
                                                  page_no:
                                                      int.parse(frompage.text) +
                                                          index,
                                                  listen_date: intl.DateFormat(
                                                          'yyyy-MM-dd')
                                                      .format(DateTime.now()),
                                                  listener_name:
                                                      config<SharedPreferences>()
                                                          .getString('TeacherName')!,
                                                  Courses_Name: 'p_hasan')
                                              .toMap()),
                                      frompage: int.parse(frompage.text),
                                      topage: int.parse(topage.text),
                                      name: studentname.text))
                                  : {
                                      showSnackBar(
                                          context: context,
                                          text: 'الصفحات مدخلة بصيغة خاطئة',
                                          color: Colors.red,
                                          icon: Icons.error_outline_outlined)
                                    };
                            },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
