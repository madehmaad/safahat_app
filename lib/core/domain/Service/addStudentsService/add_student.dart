import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/Gsheets/addStudentSheet.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_export.dart';

class addStudentService extends Service {
  Future<Model> addStudent({
    required Map<String, dynamic> student,
  }) async {
    try {
      await StudentSheetsApi.init();
      await StudentSheetsApi.userSheet!.values.map.appendRow(student);
      return successExport();
    } catch (e) {
      return failedEnterdModel();
    }
  }
}
