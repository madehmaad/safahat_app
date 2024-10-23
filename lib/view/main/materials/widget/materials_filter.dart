import 'package:dr_alshaal/view/main/materials/view_model/materials_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/category/category.dart';
import '../../../../models/topic/topic.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../../shared_widget/topic _icon.dart';

class MaterialsFilter extends StatelessWidget {
  MaterialsFilter({Key? key}) : super(key: key);
  final MaterialsViewModel materialsViewModel = Get.find();

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
                onTap: () => materialsViewModel.changeOrderBy(),
                child: SvgPicture.asset(
                  ImageAssets.sort,
                  width: 25,
                  height: 25,
                  color: materialsViewModel.orderBy.value == 'ASC'
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
          width: MediaQuery.of(context).size.width * 0.35,
          child: Center(
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: materialsViewModel.topicList
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
                                  style: const TextStyle(
                                      fontSize: 14, color: DesignColors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  value: materialsViewModel.selectedTopic.value ??
                      materialsViewModel.topicList?.first,
                  onChanged: (value) {
                    materialsViewModel.changeTopic(value!);
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
                  // color: DesignColors.white),
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
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: materialsViewModel.subjectList
                      ?.map((item) => DropdownMenuItem<Category>(
                            value: item,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                  value: materialsViewModel.selectedSubject.value ??
                      materialsViewModel.subjectList?.first,
                  onChanged: (value) {
                    materialsViewModel.changeSubject(value!);
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
    );
  }
}
