import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:pages_app/core/domain/Service/yourPages/your_pages_service.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/failed_export.dart';
import 'package:pages_app/core/domain/model/success_export.dart';
import 'package:path_provider/path_provider.dart';

class exportToExcel extends Service {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/hasan/hasan_pages.xlsx');
  }

  Future<File> writeCounter(Excel excel) async {
    final file = await _localFile;
    return file.writeAsBytes(excel.encode()!);
  }

  Future<Model> exportToexcel(BuildContext context) async {
    try {
      final excel = Excel.createExcel();
      final sheet = excel[excel.getDefaultSheet() as String];
      try {
        await YourPagesService().getYourPages();
        for (var i = 0; i < pagesList.length; i++) {
          sheet.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
              TextCellValue('full_name'));
          sheet.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0),
              TextCellValue('page_no'));
          sheet.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0),
              TextCellValue('listen_date'));
          sheet.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0),
              TextCellValue('listener_name'));
          sheet.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0),
              TextCellValue('Courses_Name'));

          sheet.appendRow([
            TextCellValue(pagesList[i].full_name),
            IntCellValue(pagesList[i].page),
            TextCellValue(pagesList[i].listen_date),
            TextCellValue(pagesList[i].listener_name),
            TextCellValue('p_hasan')
          ]);
        }

        await writeCounter(excel);

        return successExport();
      } catch (e) {
        print(e);
        return failedExport();
      }
    } catch (e) {
      print(e);
      return failedExport();
    }
  }
}
