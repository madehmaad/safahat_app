import 'package:flutter/material.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/core/Config/extension_string.dart';

GlobalKey<FormState> form1 = GlobalKey<FormState>();
GlobalKey<FormState> form2 = GlobalKey<FormState>();
Widget entryContainer(BuildContext context, String txt) {
  return Container(
    width: MediaQuery.sizeOf(context).width / 3.1,
    height: MediaQuery.sizeOf(context).height / 18,
    child: Center(child: textDinar18Light(txt)),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(113, 176, 176, 176).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(colors: grad)),
  );
}

Widget greycontainer(BuildContext context, String txt) {
  return Container(
      width: MediaQuery.sizeOf(context).width / 2.8,
      height: MediaQuery.sizeOf(context).height / 20,
      child: Center(child: textBlack13Bold(txt)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(94, 209, 205, 205)));
}

Widget greyenterpage(
    BuildContext context, TextEditingController controller, GlobalKey form) {
  return Container(
      width: MediaQuery.sizeOf(context).width / 2.8,
      height: MediaQuery.sizeOf(context).height / 10,
      child: Center(
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (!RegExp(r"^[0-9]+$").hasMatch(value!) ||
                  int.parse(value) > 604 ||
                  int.parse(value) == 0) {
                return "قيمة خاطئة";
              } else {}
            },
            cursorHeight: MediaQuery.sizeOf(context).height / 25,
            controller: controller,
            cursorColor: Themecolor,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Bahnschrift', color: Themecolor),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(94, 209, 205, 205),
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromARGB(109, 26, 26, 26)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromARGB(109, 26, 26, 26)),
              ),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(125, 24, 24, 24)),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ));
  // decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(12),
  //     color: Color.fromARGB(94, 209, 205, 205)));
}

Widget greyAddStudent(BuildContext context, TextEditingController controller,
    GlobalKey form, double width) {
  return Container(
      width: MediaQuery.sizeOf(context).width / width,
      height: MediaQuery.sizeOf(context).height / 10,
      child: Center(
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            validator: (value) {
              if (RegExp(r"^[0-9]+$").hasMatch(value!) || value.isEmpty) {
                return "قيمة خاطئة";
              } else {}
            },
            cursorHeight: MediaQuery.sizeOf(context).height / 25,
            controller: controller,
            cursorColor: Themecolor,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, fontFamily: 'Dinar', color: Themecolor),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(94, 209, 205, 205),
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromARGB(109, 26, 26, 26)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromARGB(109, 26, 26, 26)),
              ),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(125, 24, 24, 24)),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ));
  // decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(12),
  //     color: Color.fromARGB(94, 209, 205, 205)));
}
