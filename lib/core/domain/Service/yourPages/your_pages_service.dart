import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/url.dart';
import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Exception_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/page_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<PageDataModel> yourpagesList = [];
List<PageDataModel> pagesList = [];
List<PageDataModel> listPageDataModel = [];

class YourPagesService extends Service {
  Future<List<Model>> getYourPages() async {
    try {
      response = await dio.get(pagesDataUrl);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        List<PageDataModel> result = List.generate(
            temp.length, (index) => PageDataModel.fromMap(temp[index]));
        listPageDataModel = List.generate(
            temp.length, (index) => PageDataModel.fromMap(temp[index]));
        pagesList.clear();
        pagesList = result;
        yourpagesList.clear();
        result.forEach((element) {
          if (element.listener_name ==
              config<SharedPreferences>().getString('TeacherName')) {
            yourpagesList.add(element);
          }
        });
        // print(temp);

        return yourpagesList;
      } else {
        return [await ErrorModel(error: response.statusMessage!)];
      }
    } catch (e) {
      return [await ExceptionModel(excption: e.toString())];
    }
  }
}
