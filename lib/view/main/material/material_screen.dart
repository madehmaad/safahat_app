import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:dr_alshaal/view/main/material/view_model/material_view_model.dart';
import 'package:dr_alshaal/view/main/material/widget/youtube_player.dart';
import 'package:dr_alshaal/view/main/player/widget/home_player.dart';
import 'package:dr_alshaal/view/main/player/widget/media_player.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/env.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors.dart';
import '../../utils/buttons/customized_filled_button.dart';
import '../../utils/buttons/customized_outlined_button.dart';
import '../../utils/widgets/error_screen.dart';
import '../../utils/widgets/full_loader.dart';
import '../favorite/widget/add_favorite_screen.dart';
import '../player/view_model/player_view_model.dart';
import '../search/view_model/search_view_model.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
  AppController appController = Get.find();
  ScrollController navController = ScrollController();

  @override
  void initState() {
    navController.addListener(() {
      if (navController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (appController.navBarIsVisible.value) {
          appController.navBarIsVisible.value = false;
        }
      }
      if (navController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!appController.navBarIsVisible.value) {
          appController.navBarIsVisible.value = true;
        }
      }
    });
    super.initState();
  }

  @override
  Future<void> dispose() async {
    materialViewModel.youtubePlayerController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(const Duration(milliseconds: 200),
        () => appController.navBarIsVisible.value = true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return const Scaffold(
          body: YouTubePlayer(),
        );
      } else {
        return WillPopScope(
          onWillPop: () async {
            materialViewModel.showYoutube.value = false;
            return true;
          },
          child: Obx(
            () => BaseScaffold(
                body: SafeArea(
              child: Column(
                children: [
                  Container(
                    color: DesignColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              materialViewModel.showYoutube.value = false;
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              ImageAssets.back,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                child: Text(
                                  materialViewModel.materialModel?.title ??
                                      'material'.tr,
                                  style: const TextStyle(
                                      color: DesignColors.brown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20)
                        ],
                      ),
                    ),
                  ),
                  materialViewModel.getMainLoading
                      ? const FullLoader()
                      : !materialViewModel.status
                          ? ErrorScreen(
                              refresh: () => materialViewModel.getAllData())
                          : Expanded(
                              child: SingleChildScrollView(
                                controller: navController,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: double.infinity,
                                          child: materialViewModel
                                                  .showYoutube.value
                                              ? const YouTubePlayer()
                                              : null),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat(
                                                      "EEEE dd/MM/yyyy", 'ar')
                                                  .format(DateTime.parse(
                                                      materialViewModel
                                                          .materialModel
                                                          ?.materialDate)),
                                              style: const TextStyle(
                                                  color: DesignColors.brown,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                if (materialViewModel
                                                            .materialModel!
                                                            .featuredVideo !=
                                                        null ||
                                                    materialViewModel
                                                        .materialModel!
                                                        .attachments!
                                                        .isNotEmpty)
                                                  InkWell(
                                                    onTap: () {
                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  200),
                                                          () => appController
                                                              .navBarIsVisible
                                                              .value = true);
                                                      PlayerViewModel
                                                          controller = Get.put(
                                                              PlayerViewModel());
                                                      controller.setMainLoading(
                                                          false);
                                                      controller.materialModel =
                                                          materialViewModel
                                                              .materialModel;
                                                      if (materialViewModel
                                                              .materialModel
                                                              ?.featuredVideo !=
                                                          null) {
                                                        controller.addVideoUrl(
                                                            materialViewModel
                                                                .materialModel
                                                                ?.featuredVideo);
                                                      }
                                                      materialViewModel
                                                          .youtubePlayerController
                                                          .pause();

                                                      Get.toNamed(AppRoutes
                                                          .networkPlayer);
                                                    },
                                                    child: Container(
                                                      width: 160,
                                                      decoration: BoxDecoration(
                                                          color: DesignColors
                                                              .white,
                                                          border: Border.all(
                                                              color:
                                                                  DesignColors
                                                                      .primary,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  ImageAssets
                                                                      .downloadButton,
                                                                  width: 25,
                                                                  height: 25,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  'listen_and_download'
                                                                      .tr,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: DesignColors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    materialViewModel
                                                        .increaseFontSize();
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageAssets.zoomIn,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    materialViewModel
                                                        .decreaseFontSize();
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageAssets.zoomOut,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    final FavoriteViewModel
                                                        favoriteViewModel =
                                                        Get.find();
                                                    favoriteViewModel
                                                        .currentId = null;
                                                    Get.dialog(AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      scrollable: true,
                                                      title: const Center(
                                                          child: Text(
                                                              'إضافة إلى المفضلة')),
                                                      content: SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          child:
                                                              AddFavoriteScreen(
                                                                  isAdd: true)),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            CustomizedFilledButton(
                                                                width: 100,
                                                                text: 'إضافة',
                                                                function: () {
                                                                  favoriteViewModel.addMaterial(
                                                                      title: materialViewModel
                                                                              .materialModel
                                                                              ?.title ??
                                                                          '',
                                                                      slug: materialViewModel
                                                                              .materialModel
                                                                              ?.slug ??
                                                                          '',
                                                                      imageUrl:
                                                                          materialViewModel.materialModel?.mainImage ??
                                                                              '');
                                                                  Get.back();
                                                                  favoriteViewModel
                                                                          .currentId =
                                                                      null;
                                                                }),
                                                            CustomizedOutlinedButton(
                                                                width: 100,
                                                                text: 'إلغاء',
                                                                function: () {
                                                                  Get.back();
                                                                  favoriteViewModel
                                                                          .currentId =
                                                                      null;
                                                                }),
                                                          ],
                                                        ),
                                                      ],
                                                    ));
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageAssets.addFavorite,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    Share.share(
                                                        '${Env.appLink}${materialViewModel.materialSlug}');
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageAssets.share,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => Html(
                                                data: materialViewModel
                                                        .materialModel
                                                        ?.description ??
                                                    '',
                                                style: {
                                                  "span": Style(
                                                      fontSize: FontSize(
                                                          materialViewModel
                                                              .fontSize.value),
                                                      // padding: EdgeInsets.zero,
                                                      margin: Margins.zero),
                                                  "p": Style(
                                                      fontSize: FontSize(
                                                          materialViewModel
                                                              .fontSize.value),
                                                      // padding: EdgeInsets.zero,
                                                      margin: Margins.zero),
                                                },
                                                onLinkTap: (String? url,
                                                    Map<String, String>
                                                        attributes,
                                                    var element) async {
                                                  launchUrl(Uri.parse(url!));
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            if (materialViewModel.materialModel!
                                                .tags!.isNotEmpty)
                                              Text(
                                                'opening_word'.tr,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    color: DesignColors.brown),
                                              ),
                                            Wrap(
                                              children: [
                                                ...materialViewModel
                                                    .materialModel!.tags!
                                                    .map((e) => InkWell(
                                                          onTap: () {
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                                () => appController
                                                                    .navBarIsVisible
                                                                    .value = true);
                                                            SearchViewModel
                                                                searchViewModel =
                                                                Get.put(
                                                                    SearchViewModel());
                                                            searchViewModel
                                                                .query = e.name;
                                                            searchViewModel
                                                                .getAllData();
                                                            Get.toNamed(
                                                                AppRoutes
                                                                    .search);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      DesignColors
                                                                          .white,
                                                                  border: Border.all(
                                                                      color: DesignColors
                                                                          .primary,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                                child: Text(
                                                                  e.name,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                ],
              ),
            )),
          ),
        );
      }
    });
  }
}
