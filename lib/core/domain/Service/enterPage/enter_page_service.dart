import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Teachers.dart';
import 'package:pages_app/core/domain/Service/Gsheets/gsheet.dart';
import 'package:pages_app/core/domain/Service/url.dart';
import 'package:pages_app/core/domain/model/Exception_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/blocked_model.dart';
import 'package:pages_app/core/domain/model/done_page_model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/page_data.dart';
import 'package:pages_app/core/domain/model/success_enterd_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<int> donepagesList = [];
List<int> nodonepagesList = [];


class PageService extends Service {
  Future<Model> addPages(
      {required List<Map<String, dynamic>> pages,
      required int frompage,
      required int topage,
      required String name}) async {
    try {
      await TeachersService().getTeachers();
      if (!Teachers.where((element) =>
              element.name ==
              config<SharedPreferences>().getString('TeacherName'))
          .first
          .isBlocked) {
        response = await dio.get(pagesDataUrl);
        dynamic temp = response.data;
        bool donepage = false;

        List<PageDataModel> result = List.generate(temp.length,
            (index) => PageDataModel.fromMap(response.data[index]));

        nodonepagesList.clear();
        donepagesList.clear();

        for (var j = frompage; j <= topage; j++) {
          for (var i = 0; i < result.length; i++) {
            if (result[i].full_name == name) {
              if (result[i].page == j) {
                donepage = true;
                donepagesList.add(j);
              }
            }
          }
        }

        for (var j = frompage; j <= topage; j++) {
          nodonepagesList.add(j);
        }
        for (var j = frompage; j <= topage; j++) {
          if (donepagesList.contains(j)) {
            nodonepagesList.remove(j);
          }
        }

        if (donepage) {
          return donePageModel();
        } else {
          try {
            bool result =
                await UserSheetsApi.userSheet!.values.map.appendRows(pages);
            if (result) {
              return scucessEnteredPageModel();
            } else {
              return failedEnterdModel();
            }
          } catch (e) {
            return ExceptionModel(excption: e.toString());
          }
        }
      } else {
        print(Teachers.where((element) =>
                element.name ==
                config<SharedPreferences>().getString('TeacherName'))
            .first
            .isBlocked);

        return BlockedModel();
      }
    } catch (e) {
      return ExceptionModel(excption: e.toString());
    }
  }

  Future<bool> adddonePages({
    required List<Map<String, dynamic>> pages,
  }) async {
    
    return await UserSheetsApi.userSheet!.values.map.appendRows(pages);
  }
}
