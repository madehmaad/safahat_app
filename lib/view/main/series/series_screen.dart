import 'package:dr_alshaal/config/functions.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/materials/view_model/materials_view_model.dart';
import 'package:dr_alshaal/view/main/series/view_model/series_view_model.dart';
import 'package:dr_alshaal/view/main/series/widget/series_card.dart';
import 'package:dr_alshaal/view/main/series/widget/series_filter.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:dr_alshaal/view/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({Key? key}) : super(key: key);

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  final SeriesViewModel seriesViewModel = Get.put(SeriesViewModel());
  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !seriesViewModel.getPaginationLoading) {
      if (seriesViewModel.series?.nextPageUrl != null) {
        seriesViewModel.getSeriesPagination();
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
    return Obx(
      () => BaseScaffold(
        appBar: appBarCustom(
          title: seriesViewModel.selectedSubject.value?.title ?? 'series'.tr,
          backIcon: true,
        ),
        body: seriesViewModel.getMainLoading
            ? const FullLoader()
            : !seriesViewModel.status
                ? ErrorScreen(refresh: () => seriesViewModel.getAllData())
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(children: [
                      SeriesFilter(),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Obx(
                          () => seriesViewModel.getActionLoading
                              ? const FullLoader()
                              : Column(
                                  children: [
                                    Expanded(
                                      child: isTablet()
                                          ? GridView.builder(
                                              controller: scrollController,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: seriesViewModel
                                                  .series!.data.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent: 350,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                      onTap: () {
                                                        MaterialsViewModel
                                                            materialsViewModel =
                                                            Get.put(
                                                                MaterialsViewModel());
                                                        materialsViewModel
                                                                .selectedSeriesId =
                                                            seriesViewModel
                                                                .series!
                                                                .data[index]
                                                                .id;
                                                        materialsViewModel
                                                                .selectedSeriesName =
                                                            seriesViewModel
                                                                .series!
                                                                .data[index]
                                                                .title;
                                                        materialsViewModel
                                                            .getAllData();
                                                        Get.toNamed(AppRoutes
                                                            .materials);
                                                      },
                                                      child: SeriesCard(
                                                          seriese:
                                                              seriesViewModel
                                                                      .series
                                                                      ?.data[
                                                                  index])),
                                            )
                                          : ListView.separated(
                                              controller: scrollController,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: seriesViewModel
                                                  .series!.data.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                height: 5,
                                              ),
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                      onTap: () {
                                                        //!..
                                                        MaterialsViewModel
                                                            materialsViewModel =
                                                            Get.put(
                                                                MaterialsViewModel());
                                                        materialsViewModel
                                                                .selectedSeriesId =
                                                            seriesViewModel
                                                                .series!
                                                                .data[index]
                                                                .id;
                                                        materialsViewModel
                                                                .selectedSeriesName =
                                                            seriesViewModel
                                                                .series!
                                                                .data[index]
                                                                .title;
                                                        materialsViewModel
                                                                .selectedSeriesSlug =
                                                            seriesViewModel
                                                                .series!
                                                                .data[index]
                                                                .slug;
                                                        materialsViewModel
                                                            .getAllData();
                                                        Get.toNamed(AppRoutes
                                                            .materials);
                                                      },
                                                      child: SeriesCard(
                                                          seriese:
                                                              seriesViewModel
                                                                      .series
                                                                      ?.data[
                                                                  index])),
                                            ),
                                    ),
                                    seriesViewModel.getPaginationLoading
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
