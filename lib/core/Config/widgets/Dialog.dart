import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/Service/enterPage/enter_page_service.dart';
import 'package:pages_app/core/domain/Service/yourPages/your_pages_service.dart';
import 'package:pages_app/core/domain/model/entered_page_model.dart';
import 'package:pages_app/core/domain/model/failed_export.dart';
import 'package:pages_app/views/Admin/bloc/export_pages_bloc.dart';
import 'package:pages_app/views/EnterPages/Enter_Pages.dart';
import 'package:pages_app/views/EnterPages/bloc%20done/done_page_bloc.dart';
import 'package:pages_app/views/Login/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

Future showDublicateDialog({
  BuildContext? context,
  String? message,
}) {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        elevation: 1,
        // icon: Icon(Icons.error_outline_outlined),
        title: Center(
          child: Text('صفحات مكررة',
              style: TextStyle(
                  fontSize: 17, color: Colors.red, fontFamily: 'Cairo')),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            ' لم يتم تسجيل الصفحات المدخلة بسبب وجود الصفحات المكررة التالية \n ${message}',
            style: TextStyle(fontFamily: 'Dinar'),
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton(
              child: Text(
                'تم',
                style: TextStyle(fontFamily: 'Dinar', fontSize: 17),
              ),
              onPressed: () {
                Navigator.pop(context);
                (nodonepagesList.isNotEmpty)
                    ? {
                        showConfirmDialog(
                          message: "هل تريد إدخال باقي الصفحات غير المسمعة؟",
                          context: context,
                        )
                      }
                    : {};
              },
            ),
          )
        ],
      );
    },
  );
}

Future showBlockedDialog({
  BuildContext? context,
}) {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        elevation: 1,
        // icon: Icon(Icons.error_outline_outlined),
        title: Center(
          child: Text('انتهت صلاحية الجلسة',
              style: TextStyle(
                  fontSize: 17, color: Colors.red, fontFamily: 'Cairo')),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            ' انتهت صلاحية الجلسة سيتم تسجيل الخروج',
            style: TextStyle(fontFamily: 'Dinar'),
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton(
              child: Text(
                'تم',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Cairo', color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context, false);
                Navigator.pop(context, false);
                yourpagesList.clear();
                config.get<SharedPreferences>().clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => logscreen()));
              },
            ),
          )
        ],
      );
    },
  );
}

Future showNoAccessDialog({
  BuildContext? context,
}) {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        elevation: 1,
        // icon: Icon(Icons.error_outline_outlined),
        title: Center(
          child: Text('خطأ',
              style: TextStyle(
                  fontSize: 17, color: Colors.red, fontFamily: 'Cairo')),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'لا يمكنك الانتقال لهذا القسم بسبب عدم امتلاك الصلاحية اللازمة',
            style: TextStyle(fontFamily: 'Dinar'),
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton(
              child: Text(
                'تم',
                style: TextStyle(
                    fontSize: 17, fontFamily: 'Cairo', color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      );
    },
  );
}

Future showUseLapDialog({
  BuildContext? context,
}) {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        elevation: 1,
        // icon: Icon(Icons.error_outline_outlined),
        title: Center(
          child: Text('تنبيه',
              style: TextStyle(
                  fontSize: 17, color: Colors.red, fontFamily: 'Cairo')),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'للاستفادة من ميزات هذا القسم استخدم التطبيق الموجود على لابتوب الإدارة',
            style: TextStyle(fontFamily: 'Dinar'),
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton(
              child: Text(
                'تم',
                style: TextStyle(
                    fontSize: 17, fontFamily: 'Cairo', color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      );
    },
  );
}
Future<bool?> showConfirmDialog({
  required String message,
  BuildContext? context,
}) async {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return BlocProvider(
        create: (context) => enterdonePageBloc(),
        child: BlocConsumer<enterdonePageBloc, enterdonePageState>(
          listener: (context, state) {
            if (state is SuccessenterdonePage) {
              Navigator.pop(context);
              showSnackBar(
                context: context,
                text: 'تم إدخال الصفحات بنجاح',
                color: Colors.green,
                icon: Icons.check_circle_outline,
              );
            }
          },
          builder: (context, state) {
            return (state is LoadingToenterdonePage)
                ? AlertDialog(
                    content: const CupertinoActivityIndicator(
                        color: Themecolor, radius: 20),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      title: const Text('تأكيد',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontFamily: 'Cairo')),
                      content: Text(
                        message,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Dinar'),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'لا',
                            style: TextStyle(fontFamily: 'Dinar'),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text('نعم',
                              style: TextStyle(fontFamily: 'Dinar')),
                          onPressed: () {
                            context.read<enterdonePageBloc>().add(enterdonePage(
                                  page: List.generate(
                                      nodonepagesList.length,
                                      (index) => enteredPage(
                                              full_name: studentname.text,
                                              page_no: nodonepagesList[index],
                                              listen_date:
                                                  intl.DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.now()),
                                              listener_name:
                                                  config<SharedPreferences>()
                                                      .getString(
                                                          'TeacherName')!,
                                              Courses_Name: 'p_hasan')
                                          .toMap()),
                                ));
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      );
    },
  );
}

Future<bool?> showExitConfirmDialog(
    {String? message, bool? withReturn, required BuildContext context}) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تسجيل خروج',
              style: TextStyle(
                  fontSize: 17, color: Colors.red, fontFamily: 'Cairo')),
          content: Text(
            'هل أنت متأكد من رغبتك في تسجيل الخروج ؟',
            style: TextStyle(fontFamily: 'Dinar'),
          ),
          actions: [
            TextButton(
              child: const Text(
                'لا',
                style: TextStyle(fontFamily: 'Dinar'),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text(
                'نعم',
                style: TextStyle(fontFamily: 'Dinar'),
              ),
              onPressed: () {
                config.get<SharedPreferences>().clear();
                yourpagesList.clear();
                Navigator.pop(context, false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => logscreen()));
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<bool?> showExportDialog({
  BuildContext? context,
}) async {
  return showCupertinoDialog(
    context: context!,
    builder: (context) {
      return BlocProvider(
        create: (context) => exportPagesBloc(),
        child: BlocConsumer<exportPagesBloc, exportPagesState>(
          listener: (context, state) {
            if (state is SuccesseexportPages) {
              // Navigator.pop(context);
              Navigator.pop(context);
              showSnackBar(
                context: context,
                text: 'تم تصدير الملف بنجاح',
                color: Colors.green,
                icon: Icons.check_circle_outline,
              );
            } else if (state is ErrorexportPages ||
                state is ExcptionexportPages) {
              Navigator.pop(context);
              showSnackBar(
                context: context,
                text: 'حدث خطأ خلال تصدير الملف',
                color: Colors.red,
                icon: Icons.error_outline_outlined,
              );
            }
          },
          builder: (context, state) {
            return (state is LoadingToexportPages)
                ? AlertDialog(
                    content: const CupertinoActivityIndicator(
                        color: Themecolor, radius: 20),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      title: const Text('تأكيد',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontFamily: 'Cairo')),
                      content: Text(
                        'هل تريد فعلا تصدير الصفحات بصيغة ملف إكسل؟',
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Dinar'),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'لا',
                            style: TextStyle(fontFamily: 'Dinar'),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text('نعم',
                              style: TextStyle(fontFamily: 'Dinar')),
                          onPressed: () {
                            // Navigator.pop(context);
                            context
                                .read<exportPagesBloc>()
                                .add(exportPages(context: context));
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      );
    },
  );
}
