import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/addStudentsService/add_student.dart';
import 'package:pages_app/core/domain/Service/enterPage/enter_page_service.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/blocked_model.dart';
import 'package:pages_app/core/domain/model/done_page_model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_enterd_page.dart';
import 'package:pages_app/core/domain/model/success_export.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class add_studentBloc extends Bloc<add_studentEvent, add_studentState> {
  add_studentBloc() : super(add_studentInitial()) {
    on<add_student>((event, emit) async {
      emit(LoadingToadd_student());
      Model temp = await addStudentService().addStudent(student: event.student);

      if (temp is successExport) {
        emit(Successadd_student());
      } else if (temp is failedEnterdModel) {
        emit(Excptionadd_student());
      
      }
    });
  }
}
