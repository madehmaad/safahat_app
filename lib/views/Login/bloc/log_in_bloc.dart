import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Teachers.dart';

import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Exception_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/Teacher_model.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<Login>((event, emit) async {
      emit(LoadingToLogin());
      List<Model> temp = await TeachersService().getTeachers();

      if (temp is List<TeacherModel>) {
       
        emit(SuccessInLogin());
      } else if (temp is List<ErrorModel>) {
        emit(ErrorInLogin(error: ErrorModel(error: temp.toString())));
      } else {
        emit(ExcptionInLogin(excption: temp as List<ExceptionModel>));
      }
    });
  }
}
