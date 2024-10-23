import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/routes.dart';
import '../../material/view_model/material_view_model.dart';
import '../view_model/search_view_model.dart';
import 'material_card.dart';

class MaterialsList extends StatefulWidget {
  final Category category;

  const MaterialsList({Key? key, required this.category}) : super(key: key);

  @override
  State<MaterialsList> createState() => _MaterialsListState();
}

class _MaterialsListState extends State<MaterialsList> {
  final SearchViewModel searchViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category.title,
                  style: const TextStyle(color: DesignColors.brown, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                InkWell(
                  onTap: () {
                    searchViewModel.searchPagination(widget.category);
                  },
                  child: Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: DesignColors.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'see_more'.tr,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: DesignColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.category.materials?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 0,
                    height: 10,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                        materialViewModel.materialSlug = widget.category.materials?[index].slug;
                        materialViewModel.getAllData();
                        Get.toNamed(AppRoutes.material);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child:
                            SizedBox(width: 250, child: MaterialCard(materialModel: widget.category.materials![index])),
                      )),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
