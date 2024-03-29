import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/entrycontainer.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';
import 'package:pages_app/views/Admin/Add%20Student/bloc/add_student_bloc.dart';


TextEditingController name = TextEditingController();
TextEditingController group = TextEditingController();
TextEditingController id = TextEditingController();
GlobalKey<FormState> formName = GlobalKey<FormState>();
GlobalKey<FormState> formGroup = GlobalKey<FormState>();
GlobalKey<FormState> formId = GlobalKey<FormState>();
class addStudentPage extends StatelessWidget {
  const addStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
Future<bool?> showModalBottomSheetAddStudent({required BuildContext context}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return BlocProvider(
          create: (context) => add_studentBloc(),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              gradient: LinearGradient(
                  colors: grad,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              color: Color.fromARGB(255, 221, 198, 247),
              image: DecorationImage(
                image: AssetImage("assets/زخرفة كاملة.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocConsumer<add_studentBloc, add_studentState>(
              listener: (context, state) {
                if (state is Successadd_student) {
                  Navigator.pop(context);
                  showSnackBar(
                      context: context,
                      text: 'تم إضافة الطالب بنجاح',
                      color: Colors.green,
                      icon: Icons.check);
                  id.clear();
                  name.clear();
                  group.clear();
                } else if (state is Excptionadd_student) {
                  Navigator.pop(context);
                  showSnackBar(
                      context: context,
                      text: 'حدث خطأ ما ... لم يتم إضافة الطالب',
                      color: Colors.red,
                      icon: Icons.error_outline);
                  id.clear();
                  name.clear();
                  group.clear();
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      textDinar25Light('إضافة طالب'),
                      Divider(
                        color: Colors.white,
                        thickness: 3,
                        endIndent: 30,
                        indent: 30,
                      ),
                      textDinar18Light('اسم الطالب'),
                      greyAddStudent(context, name, formName, 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              textDinar18Light('اسم الحلقة'),
                              greyAddStudent(context, group, formGroup, 2.3),
                            ],
                          ),
                          Column(
                            children: [
                              textDinar18Light('رقم الطالب'),
                              greyAddStudent(context, id, formId, 2.3),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 50,
                          width: 250,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 117, 21, 226))),
                            child: (state is LoadingToadd_student)
                                ? Center(
                                    child: const CupertinoActivityIndicator(
                                        color: Colors.white, radius: 15),
                                  )
                                : Center(
                                    child: const Text(
                                      'تـسـجـيـل الطالب',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                            onPressed: (state is LoadingToadd_student)
                                ? null
                                : () async {
                                    ((formName.currentState?.validate() ??
                                                true) &&
                                            (formGroup.currentState
                                                    ?.validate() ??
                                                true) &&
                                            (formId.currentState?.validate() ??
                                                true))
                                        ? context.read<add_studentBloc>().add(
                                            add_student(
                                                student: StudentModel(
                                                        id: id.text,
                                                        group: group.text,
                                                        name: name.text,
                                                        password: 1000 +
                                                            Random().nextInt(
                                                                9999 - 1000))
                                                    .toMap()))
                                        : Navigator.pop(context);
                                    showSnackBar(
                                        context: context,
                                        text: 'القيم المدخلة خاطئة',
                                        color: Colors.red,
                                        icon: Icons.error_outline);
                                  },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }));
}
