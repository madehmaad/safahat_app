import 'package:dr_alshaal/view/main/series/view_model/series_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/category/category.dart';
import '../../../../models/topic/topic.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../../shared_widget/topic _icon.dart';

class SeriesFilter extends StatelessWidget {
  SeriesFilter({Key? key}) : super(key: key);
  final SeriesViewModel seriesViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Center(
            child: Obx(() {
              return InkWell(
                onTap: () => seriesViewModel.changeOrderBy(),
                child: SvgPicture.asset(
                  ImageAssets.sort,
                  width: 25,
                  height: 25,
                  color: seriesViewModel.orderBy.value == 'ASC'
                      ? DesignColors.brown
                      : DesignColors.gray2,
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Center(
            child: Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: DesignColors.primary,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: seriesViewModel.topicList
                        ?.map((item) => DropdownMenuItem<Topic>(
                              value: item,
                              child: Row(
                                children: [
                                  getTopicIcon(item) ?? const SizedBox(),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: DesignColors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    value: seriesViewModel.selectedTopic.value ??
                        seriesViewModel.topicList?.first,
                    onChanged: (value) {
                      seriesViewModel.changeTopic(value!);
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.sizeOf(context).height / 2,
                      width: MediaQuery.sizeOf(context).width / 2.8,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollPadding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: DesignColors.primary,
                          ),
                          color: DesignColors.white),
                    ),
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
        ),
        const Spacer(),
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.35,
          child: Center(
            child: Obx(() {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: DesignColors.primary,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: seriesViewModel.subjectList
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
                                      fontSize: 14, color: DesignColors.black),
                                ),
                              ),
                            ))
                        .toList(),
                    value: seriesViewModel.selectedSubject.value ??
                        seriesViewModel.subjectList?.first,
                    onChanged: (value) {
                      seriesViewModel.changeSubject(value!);
                    },

                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.sizeOf(context).height / 2,
                      width: MediaQuery.sizeOf(context).width / 2.8,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollPadding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: DesignColors.primary,
                          ),
                          color: DesignColors.white),
                    ),
                    // buttonHeight: 30,
                    // buttonWidth: double.infinity,
                    // itemHeight: 60,
                    // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                    // buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                    // iconEnabledColor: DesignColors.primary,
                    // buttonDecoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(50),
                    // border: Border.all(
                    //   color: DesignColors.primary,
                    // ),
                    // color: DesignColors.white),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
