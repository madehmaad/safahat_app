import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/category/category.dart';
import '../../../../models/topic/topic.dart';
import '../../../../resources/colors.dart';
import '../../../utils/dialogs/customized_dialog.dart';
import '../../../utils/form_widgets/customized_text_form_field.dart';
import '../../shared_widget/topic _icon.dart';
import '../view_model/search_view_model.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({Key? key}) : super(key: key);
  final SearchViewModel searchViewModel = Get.find();
  final TextEditingController dateFrom = TextEditingController();
  final TextEditingController dateTo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'show_result_from'.tr,
              style: const TextStyle(
                  color: DesignColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.38,
              child: Center(
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: searchViewModel.topicList
                          ?.map((item) => DropdownMenuItem<Topic>(
                                value: item,
                                child: Row(
                                  children: [
                                    getTopicIcon(item) ?? const SizedBox(),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: DesignColors.black),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      value: searchViewModel.selectedTopic.value ??
                          searchViewModel.topicList?.first,
                      onChanged: (value) {
                        searchViewModel.changeTopic(value!);
                      },
                      // buttonHeight: 30,
                      // buttonWidth: double.infinity,
                      // itemHeight: 40,
                      // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // iconEnabledColor: DesignColors.primary,
                      // buttonDecoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(50),
                      //     border: Border.all(
                      //       color: DesignColors.primary,
                      //     ),
                      //     color: DesignColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'material_type'.tr,
              style: const TextStyle(
                  color: DesignColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.38,
              child: Center(
                child: Obx(() {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: searchViewModel.subjectList
                          ?.map((item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    item.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: DesignColors.black),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: searchViewModel.selectedSubject.value ??
                          searchViewModel.subjectList?.first,
                      onChanged: (value) {
                        searchViewModel.changeSubject(value!);
                      },
                      // buttonHeight: 30,
                      // buttonWidth: double.infinity,
                      // itemHeight: 60,
                      // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // iconEnabledColor: DesignColors.primary,
                      // buttonDecoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(50),
                      //     border: Border.all(
                      //       color: DesignColors.primary,
                      //     ),
                      //     color: DesignColors.white),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'file_type'.tr,
              style: const TextStyle(
                  color: DesignColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.38,
              child: Center(
                child: Obx(() {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: searchViewModel.materialAttachmentList
                          ?.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: DesignColors.black),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: searchViewModel.selectedAttachment.value ??
                          searchViewModel.materialAttachmentList?.first,
                      onChanged: (value) {
                        searchViewModel.changeAttachment(value!);
                      },
                      // buttonHeight: 30,
                      // buttonWidth: double.infinity,
                      // itemHeight: 40,
                      // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                      // iconEnabledColor: DesignColors.primary,
                      // buttonDecoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(50),
                      //     border: Border.all(
                      //       color: DesignColors.primary,
                      //     ),
                      //     color: DesignColors.white),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomizedDialog(
                          heightPCT: 400,
                          widthPCT: 600,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          // widgets: [
                          //   CalendarDatePicker2(
                          //     // initialValue: [DateTime.now()],
                          //     onValueChanged: (values) {
                          //       DateTime date = DateTime.parse(values.first.toString());
                          //       final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          //       final String formatted = formatter.format(date);
                          //       dateFrom.text = formatted;
                          //       searchViewModel.changeDateFrom(formatted);
                          //       Get.back();
                          //     },
                          //     config: CalendarDatePicker2Config(
                          //         currentDate: DateTime.now(),
                          //         calendarType: CalendarDatePicker2Type.single,
                          //         todayTextStyle: const TextStyle(color: Colors.red),
                          //         selectedDayHighlightColor: DesignColors.primary),
                          //   )
                          // ],
                        ));
              },
              child: SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.38,
                child: CustomizedTextFormField(
                  textStyle: const TextStyle(fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  editable: false,
                  label: 'from'.tr,
                  labelStyle: const TextStyle(fontSize: 16),
                  controller: dateFrom,
                  prefix: const Icon(Icons.calendar_month,
                      color: DesignColors.brown),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.cancel_outlined,
                    color: DesignColors.brown),
                onPressed: () {
                  dateFrom.clear();
                  dateTo.clear();
                  searchViewModel.clearDate();
                }),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomizedDialog(
                          heightPCT: 400,
                          widthPCT: 600,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          // widgets: [
                          //   CalendarDatePicker2(
                          //     initialValue: [DateTime.now()],
                          //     onValueChanged: (values) {
                          //       DateTime date = DateTime.parse(values.first.toString());
                          //       final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          //       final String formatted = formatter.format(date);
                          //       dateTo.text = formatted;
                          //       searchViewModel.changeDateTo(formatted);
                          //       Get.back();
                          //     },
                          //     config: CalendarDatePicker2Config(
                          //         currentDate: DateTime.now(),
                          //         calendarType: CalendarDatePicker2Type.single,
                          //         todayTextStyle: const TextStyle(color: Colors.red),
                          //         selectedDayHighlightColor: DesignColors.primary),
                          //   )
                          // ],
                        ));
              },
              child: SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.38,
                child: CustomizedTextFormField(
                  textStyle: const TextStyle(fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  label: 'to'.tr,
                  labelStyle: const TextStyle(fontSize: 16),
                  editable: false,
                  controller: dateTo,
                  prefix: const Icon(Icons.calendar_month,
                      color: DesignColors.brown),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
