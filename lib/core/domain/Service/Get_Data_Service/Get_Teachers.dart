import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/url.dart';
import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Exception_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/Teacher_model.dart';

late List<TeacherModel> Teachers = [];

class TeachersService extends Service {
  Future<List<Model>> getTeachers() async {
    try {
      response = await dio.get(teachersUrl);
      // print(response.data);
      if (response.statusCode == 200) {
        dynamic temp = response.data;

        List<TeacherModel> result = List.generate(
            temp.length, (index) => TeacherModel.fromMap(response.data[index]));
        Teachers = result;

        return result;
      } else {
        return [await ErrorModel(error: response.statusMessage!)];
      }
    } catch (e) {
      List<ExceptionModel> exception = [ExceptionModel(excption: e.toString())];
      // print(e);
      return exception;
    }
  }
}
