import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Themecolor,
        // ),
        body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/رجوع.png'),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height / 20,
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 1.3,
                          height: MediaQuery.sizeOf(context).height / 5,
                          child: Image.asset(
                            'assets/لوغو تطبيق.png',
                          ),
                        ),
                      ),
                      textBlack20BoldLight('تطبيق صفحات'),
                      textBlack17Bold('V 1.0.0'),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textDinar17Lightabout(
                                  'تطبيق موجه للمشرفين في دورة الناشئة للقرآن الكريم في جامع الحسن .'),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: textBlack18Bold('مزايا التطبيق :'),
                              ),
                              textDinar17Lightabout(
                                  '- تسجيل الدخول عن طريق حساب المشرف الخاص به.'),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 50,
                              ),
                              textDinar17Lightabout(
                                  '- إدخال الصفحات عن طريق البحث عن اسم الطالب.'),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 50,
                              ),
                              textDinar17Lightabout(
                                  '- إعلام المشرف بوجود صفحات مسمعة مسبقاً.'),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 50,
                              ),
                              textDinar17Lightabout(
                                  '- استعلام عن الصفحات التي قام بتسميعها المشرف وتاريخ تسميعها.'),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 50,
                              ),
                              textDinar17Lightabout(
                                  '- استعلام مشرف الحلقة عن جميع تفصيل صفحات طلاب حلقته المسمعة.'),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 50),
                              textDinar17Lightabout(
                                  '- تصدير جميع الصفحات المسمعة إلى ملف إكسل .'),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 50),
                              textDinar17Lightabout('- إضافة مشرفين وطلاب .'),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 50),
                              textDinar17Lightabout(
                                  '- عدد الصفحات خلال تاريخ معين.'),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 50),
                              textDinar17Lightabout('- بيان وضع طالب .'),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 3,
                        endIndent: 30,
                        indent: 30,
                      ),
                      Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/لوغو.png'))),
                      ),
                      textDinar18LightaboutBold('حقوق الملكية © 2024 '),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 50),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
