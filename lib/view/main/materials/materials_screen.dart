import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/materials/view_model/materials_view_model.dart';
import 'package:dr_alshaal/view/main/materials/widget/materials_card.dart';
import 'package:dr_alshaal/view/main/player/view_model/player_view_model.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/functions.dart';
import '../../../resources/routes.dart';
import '../../utils/widgets/error_screen.dart';
import '../../utils/widgets/full_loader.dart';
import '../../utils/widgets/loader.dart';
import '../material/view_model/material_view_model.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({Key? key}) : super(key: key);

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final MaterialsViewModel materialsViewModel = Get.put(MaterialsViewModel());
  MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
  AppController appController = Get.find();
  MaterialViewModel materialViewModel1 = Get.put(MaterialViewModel());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    materialViewModel.youtubePlayerController.dispose();

    ;
    Future.delayed(const Duration(milliseconds: 200),
        () => appController.navBarIsVisible.value = true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseScaffold(
        appBar: appBarCustom(
          title: materialsViewModel.selectedSeriesName ?? 'materials'.tr,
          backIcon: true,
        ),
        body: materialsViewModel.getMainLoading
            ? const FullLoader()
            : !materialsViewModel.status
                ? ErrorScreen(refresh: () => materialsViewModel.getAllData())
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: (materialsViewModel.materials?.length == 0)
                        ? Center(
                            child: Text('هذه السلسلة فارغة'.tr,
                                style: const TextStyle(
                                    fontSize: 18, color: DesignColors.primary),
                                textAlign: TextAlign.center),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                // MaterialsFilter(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => materialsViewModel.getActionLoading
                                        ? const FullLoader()
                                        : Column(
                                            children: [
                                              Expanded(
                                                child: isTablet()
                                                    ? GridView.builder(
                                                        controller:
                                                            scrollController,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            materialsViewModel
                                                                .materials!
                                                                .length,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          mainAxisExtent: 350,
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                        ),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            InkWell(
                                                                onTap: () {
                                                                  MaterialViewModel
                                                                      materialViewModel =
                                                                      Get.put(
                                                                          MaterialViewModel());
                                                                  materialViewModel
                                                                          .materialSlug =
                                                                      materialsViewModel
                                                                          .materials?[
                                                                              index]
                                                                          .slug;
                                                                  materialViewModel
                                                                      .getAllData();
                                                                  Get.toNamed(
                                                                      AppRoutes
                                                                          .material);
                                                                },
                                                                child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: MaterialsCard(
                                                                      materialModel:
                                                                          materialsViewModel
                                                                              .materials![index]),
                                                                )),
                                                      )
                                                    : ListView.separated(
                                                        controller:
                                                            scrollController,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            materialsViewModel
                                                                .materials!
                                                                .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                          height: 5,
                                                        ),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            InkWell(
                                                                onTap: () {
                                                                  // !.........
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      () => appController
                                                                          .navBarIsVisible
                                                                          .value = true);
                                                                  PlayerViewModel
                                                                      controller =
                                                                      Get.put(
                                                                          PlayerViewModel());
                                                                  controller
                                                                      .setMainLoading(
                                                                          false);
                                                                  controller
                                                                          .materialModel =
                                                                      materialViewModel1
                                                                          .materialModel;
                                                                  if (materialViewModel1
                                                                          .materialModel
                                                                          ?.featuredVideo !=
                                                                      null) {
                                                                    controller.addVideoUrl(materialViewModel1
                                                                        .materialModel
                                                                        ?.featuredVideo);
                                                                  }

                                                                  // !........
                                                                  MaterialViewModel
                                                                      materialViewModel =
                                                                      Get.put(
                                                                          MaterialViewModel());
                                                                  materialViewModel
                                                                          .materialSlug =
                                                                      materialsViewModel
                                                                          .materials?[
                                                                              index]
                                                                          .slug;
                                                                  materialViewModel
                                                                      .getAllData();
                                                                  Get.toNamed(
                                                                      AppRoutes
                                                                          .material);
                                                                },
                                                                child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: MaterialsCard(
                                                                      materialModel:
                                                                          materialsViewModel
                                                                              .materials![index]),
                                                                )),
                                                      ),
                                              ),
                                              materialsViewModel
                                                      .getPaginationLoading
                                                  ? const SizedBox(
                                                      height: 60,
                                                      child: Loader(),
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                  ),
                                )
                              ]),
                  ),
      ),
    );
  }
}
