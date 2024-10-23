import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/routes.dart';
import '../../../utils/widgets/loader.dart';
import '../../material/view_model/material_view_model.dart';
import '../view_model/search_view_model.dart';
import 'material_card.dart';

class MaterialList extends StatefulWidget {
  final Category category;

  const MaterialList({Key? key, required this.category}) : super(key: key);

  @override
  State<MaterialList> createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {
  final SearchViewModel searchViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
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
            ],
          ),
        ),
        Obx(() {
          return Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.category.materials?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                  height: 10,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                      materialViewModel.materialSlug = widget.category.materials?[index].slug;
                      materialViewModel.getAllData();
                      Get.toNamed(AppRoutes.material);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MaterialCard(materialModel: widget.category.materials![index]),
                    )),
              ),
              searchViewModel.getPaginationLoading
                  ? const SizedBox(
                      height: 100,
                      child: Loader(),
                    )
                  : const SizedBox()
            ],
          );
        }),
      ],
    );
  }
}
