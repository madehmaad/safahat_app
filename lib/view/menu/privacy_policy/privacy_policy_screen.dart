import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(title: 'privacy_policy'.tr, backIcon: true),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "لا يهدف هذا الموقع/ التطبيق إلى جمع بياناتك الشخصية أثناء التصفح وإنما سيتم فقط استخدام البيانات المقدمة من قبلك بمعرفتك ومحض إرادتك.",
                  style: TextStyle(
                      color: DesignColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'المعلومات الشخصية',
                  style: TextStyle(
                      color: DesignColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                  "تنطبق هذه السياسة على جميع المعلومات التي يتم جمعها أو المقدمة على موقعنا الإلكتروني/ تطبيقنا. يمكن لزوار الموقع/ التطبيق تصفحه والحصول على المعلومات التي يبحثون عنها والاشتراك في مختلف الأدوات والبرامج التي يقدمها الموقع/ التطبيق وتلقي الرسائل الإلكترونية وتحميل المواد بشكل مجاني. خلال هذه العمليات، لا نقوم بجمع سوى المعلومات الشخصية المقدمة طوعاً من قبل المتصفح لهذا الموقع، وقد يشمل ذلك، ولكن ليس على سبيل الحصر، الاسم وعنوان البريد الإلكتروني، ومعلومات الاتصال، وأية بيانات أو تفاصيل ديموغرافية أخرى. نحن لا نشارك المعلومات الشخصية التي تقدمها من خلال موقعنا على شبكة الإنترنت مع أية مؤسسة أو شركة أو حكومة أو وكالة حكومية أو أي نوع من المنظمات الأخرى. ونلتزم في الكشف عن المعلومات الشخصية في حالات استثنائية حسب قانون البلد الذي نعمل فيه. نستخدم المعلومات التي يقدمها متصفح الموقع طوعاً لتقديم عدة خدمات مثل النشرات الإخبارية عن طريق البريد الإلكتروني، ودعوات للندوات والمؤتمرات، أو تنبيهات حول برامج أو أنشطة أو مواد ننشرها على موقعنا. ",
                  style: TextStyle(
                      color: DesignColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              Text(
                'لن يتم استخدام معلوماتك لأية أغراض تجارية أبداً، ولن نقوم ببيعها، أو المتاجرة بها، أو تأجيرها، أو إفشاء أي من معلوماتك لمصلحة أي طرف ثالث خارج هذا الموقع، أو المواقع التابعة له، وسيتم الكشف عن المعلومات فقط في حالة صدور أمر بذلك من قبل سلطة قضائية أو تنظيمية في البلد الذي نعمل فيه',
                style: TextStyle(
                    color: DesignColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  ' الروابط للمواقع الأخرى على شبكة الإنترنت',
                  style: TextStyle(
                      color: DesignColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'قد يشتمل موقعنا/ تطبيقنا على روابط لمواقع أخرى على شبكة الإنترنت ولا نعتبر مسؤولين عن أساليب تجميع البيانات من قبل تلك المواقع، يمكنك الاطلاع على سياسات الخصوصية والمحتويات الخاصة بتلك المواقع التي يتم الدخول إليها.',
                style: TextStyle(
                    color: DesignColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'التعديلات على سياسة سرية وخصوصية المعلومات',
                  style: TextStyle(
                      color: DesignColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'نحتفظ بحق إجراء تغييرات على هذه السياسة إن لزم الأمر، وعند حدوث ذلك سيتم إعلام زوار الموقع/ التطبيق بذلك وإعلان ذلك على موقعنا في مكان يسهل الوصول إليه.',
                style: TextStyle(
                    color: DesignColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'الاتصال بنا',
                  style: TextStyle(
                      color: DesignColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'إذا كان لديكم أسئلة أو استفسارات أخرى حول سياسات الخصوصية هذه، يرجى مراسلتنا على البريد الإلكتروني عن طريق النقر على رابط "اتصل بنا" في الموقع أو التطبيق.',
                style: TextStyle(
                    color: DesignColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
