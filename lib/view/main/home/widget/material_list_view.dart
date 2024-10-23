import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/home/view_model/home_view_model.dart';
import 'package:dr_alshaal/view/main/home/widget/commune_card.dart';
import 'package:dr_alshaal/view/main/series/view_model/series_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/home_models/home_type_material.dart';
import '../../../utils/widgets/loader.dart';
import '../../material/view_model/material_view_model.dart';

class HomeMaterialListView extends StatefulWidget {
  final HomeTypeMaterial homeTypeMaterial;
  const HomeMaterialListView({Key? key, required this.homeTypeMaterial}) : super(key: key);

  @override
  State<HomeMaterialListView> createState() => _HomeMaterialListViewState();
}

class _HomeMaterialListViewState extends State<HomeMaterialListView> {
  HomeViewModel homeViewModel = Get.find();
  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (widget.homeTypeMaterial.materials?.nextPageUrl != null) {
        homeViewModel.getMaterialPagination(
            page: widget.homeTypeMaterial.materials!.currentPage! + 1, typeId: widget.homeTypeMaterial.type!.id!);
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.homeTypeMaterial.type?.title,
                  style: const TextStyle(fontSize: 20, color: DesignColors.brown, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    SeriesViewModel seriesViewModel = Get.put(SeriesViewModel());
                    seriesViewModel.selectedCategoryId = widget.homeTypeMaterial.type?.materialTypeId;
                    seriesViewModel.getAllData();
                    Get.toNamed(AppRoutes.series);
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
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: DesignColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: widget.homeTypeMaterial.materials!.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                              materialViewModel.materialSlug = widget.homeTypeMaterial.materials!.data[index].slug;
                              materialViewModel.getAllData();
                              Get.toNamed(AppRoutes.material);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: CommonCard(materialModel: widget.homeTypeMaterial.materials!.data[index]),
                            ))),
                  ),
                  homeViewModel.getPaginationLoadingOne &&
                          homeViewModel.selectedIndexType == widget.homeTypeMaterial.type!.id
                      ? const SizedBox(
                          width: 60,
                          child: Loader(),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
