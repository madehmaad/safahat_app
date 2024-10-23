import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/main/home/view_model/home_view_model.dart';
import 'package:dr_alshaal/view/main/home/widget/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/routes.dart';
import '../../../utils/widgets/loader.dart';
import '../../material/view_model/material_view_model.dart';

class LastPostListView extends StatefulWidget {
  const LastPostListView({Key? key}) : super(key: key);

  @override
  State<LastPostListView> createState() => _LastPostListViewState();
}

class _LastPostListViewState extends State<LastPostListView> {
  final HomeViewModel homeViewModel = Get.find();

  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (homeViewModel.lastPostModel?.nextPageUrl != null) {
        homeViewModel.getLastPostsPagination();
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
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'آخر المنشورات',
              style: TextStyle(fontSize: 20, color: DesignColors.brown, fontWeight: FontWeight.bold),
            ),
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
                        itemCount: homeViewModel.lastPostModel!.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                                materialViewModel.materialSlug = homeViewModel.lastPostModel?.data[index].slug;
                                materialViewModel.getAllData();
                                Get.toNamed(AppRoutes.material);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: PostCard(materialModel: homeViewModel.lastPostModel!.data[index]),
                              ),
                            )),
                  ),
                  homeViewModel.getPaginationLoading
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
