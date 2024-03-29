import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/addTeacherService/add_teacher.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_export.dart';

part 'add_teacher_event.dart';
part 'add_teacher_state.dart';

class addteacherBloc extends Bloc<addteacherEvent, addteacherState> {
  addteacherBloc() : super(addteacherInitial()) {
    on<addteacher>((event, emit) async {
      emit(LoadingToaddteacher());
      Model temp = await addTeacherService().addTeacher(teacher: event.teacher);

      if (temp is successExport) {
        emit(Successaddteacher());
      } else if (temp is failedEnterdModel) {
        emit(Excptionaddteacher());
      
      }
    });
  }
}
