import 'package:gsheets/gsheets.dart';
import 'package:pages_app/core/domain/Service/Gsheets/gsheet.dart';

class TeacherSheetsApi extends UserSheetsApi {
  // ?? uncomment this part of code>>
  static const creds = r'''
(your creds)
 ''';

  static const spreadsheetId = ('(your spreadsheet id)');

  static Worksheet? userSheet;
  static final _gsheets = GSheets(creds);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(spreadsheetId);

      userSheet = await _getWorkSheet(spreadsheet, title: "Sheet1");
      final firstRow = SheetsColumn.getColumns();
      userSheet!.values.insertRow(1, firstRow);
    } catch (e) {}
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}

class SheetsColumn {
  static final String id = "id";
  static final String password = "password";
  static final String name = "name";
  static final String JobType = "JobType";
  static final String isBlocked = "isBlocked";

  static List<String> getColumns() => [id, password, name, JobType, isBlocked];
}
