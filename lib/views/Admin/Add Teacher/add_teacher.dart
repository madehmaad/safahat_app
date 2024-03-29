import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/entrycontainer.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/model/Teacher_model.dart';
import 'package:pages_app/views/Admin/Add%20Student/bloc/add_student_bloc.dart';
import 'package:pages_app/views/Admin/Add%20Teacher/bloc/add_teacher_bloc.dart';

TextEditingController name = TextEditingController();
TextEditingController Job = TextEditingController();
TextEditingController id = TextEditingController();
GlobalKey<FormState> formName = GlobalKey<FormState>();
GlobalKey<FormState> formJob = GlobalKey<FormState>();
GlobalKey<FormState> formId = GlobalKey<FormState>();
Future<bool?> showModalBottomSheetAddTeacher({required BuildContext context}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return BlocProvider(
          create: (context) => addteacherBloc(),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 1,
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
            child: BlocConsumer<addteacherBloc, addteacherState>(
              listener: (context, state) {
                if (state is Successaddteacher) {
                  Navigator.pop(context);
                  showSnackBar(
                      context: context,
                      text: 'تم إضافة المشرف بنجاح',
                      color: Colors.green,
                      icon: Icons.check);
                  id.clear();
                  name.clear();
                  Job.clear();
                } else if (state is Excptionaddteacher) {
                  Navigator.pop(context);
                  showSnackBar(
                      context: context,
                      text: 'حدث خطأ ما ... لم يتم إضافة المشرف',
                      color: Colors.red,
                      icon: Icons.error_outline);
                  id.clear();
                  name.clear();
                  Job.clear();
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      textDinar25Light('إضافة مشرف'),
                      Divider(
                        color: Colors.white,
                        thickness: 3,
                        endIndent: 30,
                        indent: 30,
                      ),
                      textDinar18Light('اسم المشرف'),
                      greyAddStudent(context, name, formName, 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              textDinar18Light('طبيعة العمل'),
                              greyAddStudent(context, Job, formJob, 2.3),
                            ],
                          ),
                          Column(
                            children: [
                              textDinar18Light('رقم المشرف'),
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
                            child: (state is LoadingToaddteacher)
                                ? Center(
                                    child: const CupertinoActivityIndicator(
                                        color: Colors.white, radius: 15),
                                  )
                                : Center(
                                    child: const Text(
                                      'تـسـجـيـل المشرف',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                            onPressed: (state is LoadingToaddteacher)
                                ? null
                                : () async {
                                    ((formName.currentState?.validate() ??
                                                true) &&
                                            (formJob.currentState?.validate() ??
                                                true) &&
                                            (formId.currentState?.validate() ??
                                                true))
                                        ? context.read<addteacherBloc>().add(
                                            addteacher(
                                                teacher: TeacherModel(
                                                        id: id.text,
                                                        name: name.text,
                                                        JobType: 'f',
                                                        password: (1000 +
                                                                Random().nextInt(
                                                                    9999 -
                                                                        1000))
                                                            .toString(),
                                                        isBlocked: false)
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
