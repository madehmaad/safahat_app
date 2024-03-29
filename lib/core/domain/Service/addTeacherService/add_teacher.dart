import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/Gsheets/addTeacherSheet.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_export.dart';

class addTeacherService extends Service {
  Future<Model> addTeacher({
    required Map<String, dynamic> teacher,
  }) async {
    try {
      await TeacherSheetsApi.init();
      await TeacherSheetsApi.userSheet!.values.map.appendRow(teacher);
      return successExport();
    } catch (e) {
      return failedEnterdModel();
    }
  }
}
