import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pages_app/core/domain/Service/export/export_to_excel.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/failed_export.dart';
import 'package:pages_app/core/domain/model/success_export.dart';


part 'export_pages_event.dart';
part 'export_pages_state.dart';

class exportPagesBloc extends Bloc<exportPagesEvent, exportPagesState> {
  exportPagesBloc() : super(exportPagesInitial()) {
    on<exportPages>((event, emit) async {
      emit(LoadingToexportPages());
      Model temp = await exportToExcel().exportToexcel(event.context);

      if (temp is successExport) {
        emit(SuccesseexportPages());
        // } else if (temp is donePageModel) {
        //   emit(Donepage());
      } else if (temp is failedExport) {
        emit(ErrorexportPages());
      } else {
        emit(ExcptionexportPages());
      }
    });
  }
}
