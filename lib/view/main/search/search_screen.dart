import 'package:dr_alshaal/view/main/search/view_model/search_view_model.dart';
import 'package:dr_alshaal/view/main/search/widget/material_list.dart';
import 'package:dr_alshaal/view/main/search/widget/materials_list.dart';
import 'package:dr_alshaal/view/main/search/widget/question_list.dart';
import 'package:dr_alshaal/view/main/search/widget/question_list_vertical.dart';
import 'package:dr_alshaal/view/main/search/widget/search_filter.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category/category.dart';
import '../../../resources/colors.dart';
import '../../utils/form_widgets/customized_text_form_field.dart';
import '../../utils/widgets/base_scaffold.dart';
import '../../utils/widgets/empty_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchViewModel searchViewModel = Get.find();
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        searchViewModel.selectedSubject.value?.title != 'الكل') {
      if (searchViewModel.selectedSubject.value?.id != 'questions') {
        if (searchViewModel.itemSearch!.list![0].hasNextPage ?? false) {
          searchViewModel
              .searchPagination(searchViewModel.selectedSubject.value!);
        }
      } else {
        if (searchViewModel.itemSearch?.questionsHasNextPage ?? false) {
          searchViewModel.searchPagination(Category(id: 'questions'));
        }
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
    searchController.text = searchViewModel.query ?? '';
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'search'.tr,
        backIcon: true,
      ),
      body: Obx(
        () => searchViewModel.getMainLoading
            ? const FullLoader()
            : !searchViewModel.status
                ? ErrorScreen(refresh: () => searchViewModel.getAllData())
                : SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: 40,
                          child: CustomizedTextFormField(
                            controller: searchController,
                            prefix: const Icon(
                              Icons.search,
                              color: DesignColors.gray2,
                            ),
                            updateCursorAtTheEnd: false,
                            postfix: IconButton(
                                icon: const Icon(Icons.cancel_outlined,
                                    color: DesignColors.brown),
                                onPressed: () {
                                  if (searchController.text.isNotEmpty) {
                                    searchController.clear();
                                    searchViewModel.changeQuery('');
                                  }
                                }),
                            onTextChanged: (value) {
                              searchViewModel.changeQuery(value);
                            },
                            onTap: () {
                              if (searchController.selection ==
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          searchController.text.length - 1))) {
                                searchController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: searchController.text.length));
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SearchFilter(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Obx(
                      //   () => searchViewModel.getActionLoading
                      //       ? const Expanded(child: FullLoader())
                      //       : searchViewModel.itemSearch!.list!.isEmpty &&
                      //               searchViewModel.itemSearch!.questions!.isEmpty
                      //           ? const Expanded(child: EmptyScreen(title: 'لا يوجد مواد لعرضها'))
                      //           : searchViewModel.selectedSubject.value?.title == 'الكل'
                      //               ? Column(
                      //                   children: [
                      //                     ...searchViewModel.itemSearch!.list!
                      //                         .map((e) => MaterialsList(category: e))
                      //                         .toList(),
                      //                     if (searchViewModel.itemSearch!.questions!.isNotEmpty) const QuestionList(),
                      //                   ],
                      //                 )
                      //               : searchViewModel.selectedSubject.value?.id != 'questions'
                      //                   ? MaterialList(category: searchViewModel.itemSearch!.list!.first)
                      //                   : const QuestionListVertical(),
                      // ),
                    ]),
                  ),
      ),
    );
  }
}
