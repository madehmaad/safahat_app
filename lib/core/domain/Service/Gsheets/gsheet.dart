import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  // ?? uncomment this part of code>>
  static const credentials = '(your creds)';
  static const spreadsheetId = ('(your spreadsheet id)');

  static Worksheet? userSheet;
  static final _gsheets = GSheets(credentials);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(spreadsheetId);

      userSheet = await _getWorkSheet(spreadsheet, title: "PagesData");
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
  static final String full_name = "full_name";
  static final String page_no = "page_no";
  static final String listen_date = "listen_date";
  static final String listener_name = "listener_name";
  static final String Courses_Name = "Courses_Name";

  static List<String> getColumns() =>
      [full_name, page_no, listen_date, listener_name, Courses_Name];
}
