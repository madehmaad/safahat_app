import 'package:flutter/material.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/views/EnterPages/Enter_Pages.dart';

// ignore: must_be_immutable
class SearchAuto extends EnterPagesScreen {
  SearchAuto({
    super.key,
    required this.reg,
    required this.label,
    required this.controller,
  });
  List<String> reg;
  String label;
  TextEditingController controller;

  @override
  State<SearchAuto> createState() => _SearchAutoState();
}

class _SearchAutoState extends State<SearchAuto> {
  @override
  Widget build(BuildContext context) {
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
          return widget.reg.where((String option) {
            return option.contains(Searched.text.toLowerCase());
          });
        },

        // when user click on the suggested
        // item this function calls
        onSelected: (
          String value,
        ) {
          setState(() {
            debugPrint('You just selected $value');
            widget.controller.text = value;
            name = value;
            print(name);

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
                        color: Color.fromARGB(133, 217, 215, 215),
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
                      widget.label,
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
}
