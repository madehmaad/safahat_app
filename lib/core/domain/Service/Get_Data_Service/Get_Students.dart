import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/url.dart';
import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Exception_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';

List<StudentModel> Students = [];
List<String> Studentsnames = [];
List<String> Studentsgroups = [];

class StudentsService extends Service {
  Future<List<Model>> getStudents() async {
    try {
      response = await dio.get(studendsUrl);
      if (response.statusCode == 200) {
        dynamic temp = response.data;
        List<StudentModel> result = List.generate(
            temp.length, (index) => StudentModel.fromMap(temp[index]));
        Studentsnames = List.generate(result.length, (ind) => result[ind].name);
        Studentsgroups =
            List.generate(result.length, (index) => result[index].group);
        // print(temp);
        Students = result;
        return result;
      } else {
        return [await ErrorModel(error: response.statusMessage!)];
      }
    } catch (e) {
      return [await ExceptionModel(excption: e.toString())];
    }
  }
}
