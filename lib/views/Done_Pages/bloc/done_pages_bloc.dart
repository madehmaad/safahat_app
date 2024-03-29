import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/Get_Data_Service/Get_Students.dart';
import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/Student_model.dart';

part 'done_pages_event.dart';
part 'done_pages_state.dart';

class DonePagesBloc extends Bloc<DonePagesEvent, DonePagesState> {
  DonePagesBloc() : super(DonePagesInitial()) {
    on<DonePagesEvent>((event, emit) async {
      emit(LoadingToDonePage());
      List<Model> temp = await StudentsService().getStudents();

      if (temp is List<StudentModel>) {
        emit(SuccessDonePage());
      } else if (temp is ErrorModel) {
        emit(ErrorDonePage());
      } else if (temp is ExceptionDonePage) {
        emit(ExceptionDonePage());
      }
    });
  }
}
