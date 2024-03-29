import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/Config/extension_string.dart';
import 'package:pages_app/core/Config/widgets/snackbar.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Teachers.dart';
import 'package:pages_app/core/domain/Service/Validate_Login/ValidateUser.dart';
import 'package:pages_app/views/Login/bloc/log_in_bloc.dart';
import 'package:pages_app/views/NavigationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logscreen extends StatefulWidget {
  logscreen({super.key});

  @override
  State<logscreen> createState() => _logscreenState();
}

class _logscreenState extends State<logscreen> {
  late TextEditingController username;
  late TextEditingController password;
  late bool valuser;
  late bool valpass;
  late bool sec = false;
  late bool validate = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formuser = GlobalKey<FormState>();
  GlobalKey<FormState> formpass = GlobalKey<FormState>();
  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    valuser = false;
    valpass = false;
    sec = true;

    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => LogInBloc(),
        child: Scaffold(
          // appBar: AppBar(),
          backgroundColor: Colors.transparent,
          body: BlocConsumer<LogInBloc, LogInState>(
            listener: (context, state) {
              if (state is SuccessInLogin) {
                validate = ValidateUser()
                    .validateUser(username.text, password.text, Teachers);

                if (validate &&
                    !Teachers.where((element) => element.id == username.text)
                        .first
                        .isBlocked) {
                  String Teachername =
                      Teachers.where((element) => element.id == username.text)
                          .first
                          .name;
                  String TeacheJob =
                      Teachers.where((element) => element.id == username.text)
                          .first
                          .JobType;
                  config
                      .get<SharedPreferences>()
                      .setString('TeacherName', Teachername);
                  config
                      .get<SharedPreferences>()
                      .setString('TeacherJob', TeacheJob);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationPage(
                                selectedIndex: 0,
                              )));
                  print("Login");
                } else if (!validate ||
                    Teachers.where((element) => element.id == username.text)
                        .first
                        .isBlocked) {
                  showSnackBar(
                      context: context,
                      text: 'المعلومات المدخلة خاطئة',
                      color: Colors.red,
                      icon: Icons.error_outline_outlined);
                }
              } else if (state is ErrorInLogin || state is ExcptionInLogin) {
                showSnackBar(
                    context: context,
                    text: 'حدث خطأ... تأكد من اتصالك بالإنترنت',
                    color: Colors.red,
                    icon: Icons.wifi_off_outlined);
              }
            },
            builder: (context, state) {
              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: grad,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    image: DecorationImage(
                        image: AssetImage("assets/زخرفة كاملة.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0,
                              bottom: MediaQuery.sizeOf(context).height / 100),
                          child: textBlack14Bold(
                              'تطبيـــق دورة القــرآن الكريـــم '),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          height: MediaQuery.sizeOf(context).height / 7,
                          child: Image.asset(
                            'assets/لوغو.png',
                          ),
                        ),
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
                        Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: formkey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height / 50,
                                ),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 1.2,
                                  height: 90,
                                  child: TextFormField(
                                    key: formuser,
                                    validator: (value) {
                                      if (value!.isEmpty || value == '') {
                                        valuser = false;
                                        return "يجب إدخال اسم المستخدم";
                                      } else {
                                        valuser = true;
                                        return null;
                                      }
                                    },
                                    controller: username,
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 40,
                                    //     MediaQuery.sizeOf(context).height / 27,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          202, 255, 255, 255),
                                      fontSize: 18,
                                      letterSpacing: 2,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w100,
                                    ),
                                    cursorColor:
                                        Color.fromARGB(255, 98, 34, 162),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                198, 255, 255, 255),
                                            width: 1.5),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(64, 125, 125, 125),
                                      labelText: 'اسم المستخدم',
                                      prefixIcon: Icon(Icons.person),
                                      prefixIconColor: Colors.white,
                                      labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(125, 254, 253, 253),
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        // fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w100,
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height / 50,
                                ),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 1.2,
                                  height: 90,
                                  child: TextFormField(
                                    key: formpass,
                                    obscureText: sec,
                                    obscuringCharacter: '*',
                                    validator: (value) {
                                      if (value!.isEmpty || value == '') {
                                        valuser = false;
                                        return "يجب إدخال كلمة المرور";
                                      } else {
                                        valuser = true;
                                        return null;
                                      }
                                    },
                                    controller: password,
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 40,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          202, 255, 255, 255),
                                      fontSize: 18,
                                      letterSpacing: 2,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w100,
                                    ),
                                    cursorColor:
                                        Color.fromARGB(255, 98, 34, 162),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                198, 255, 255, 255),
                                            width: 1.5),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(64, 125, 125, 125),
                                      labelText: 'كلمة المرور',
                                      prefixIcon: Icon(Icons.lock),
                                      prefixIconColor: Colors.white,
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              sec = !sec;
                                            });
                                          },
                                          icon: (sec)
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color: const Color.fromARGB(
                                                      255, 92, 91, 91),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: const Color.fromARGB(
                                                      255, 92, 91, 91),
                                                )),
                                      labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(125, 254, 253, 253),
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        // fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w100,
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 230,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Color.fromARGB(255, 117, 21, 226))),
                              child: state is LoadingToLogin
                                  ? Center(
                                      child: const CupertinoActivityIndicator(
                                          color: Colors.white, radius: 15),
                                    )
                                  : Center(
                                      child: const Text(
                                        'تـسـجـيـل الـدخـول',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                              onPressed: (state is LoadingToLogin)
                                  ? null
                                  : () async {
                                      print(formkey.currentState?.validate());
                                      ((formkey.currentState?.validate() ??
                                              true))
                                          ? context
                                              .read<LogInBloc>()
                                              .add(Login())
                                          : {
                                              showSnackBar(
                                                  context: context,
                                                  text:
                                                      'يجب ملء جميع الحقول المطلوبة',
                                                  color: Colors.red,
                                                  icon: Icons
                                                      .error_outline_outlined)
                                            };
                                    },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
