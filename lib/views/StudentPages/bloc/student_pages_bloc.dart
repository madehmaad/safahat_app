import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/yourPages/your_pages_service.dart';
import 'package:pages_app/core/domain/model/Error_model.dart';
import 'package:pages_app/core/domain/model/Model.dart';

part 'student_pages_event.dart';
part 'student_pages_state.dart';

class StudentPagesBloc extends Bloc<StudentPagesEvent, StudentPagesState> {
  StudentPagesBloc() : super(StudentPagesInitial()) {
    on<StudentPagesEvent>((event, emit) async {
      List<Model> temp = await YourPagesService().getYourPages();

      if (temp is List<StudentPages>) {
        emit(SuccessStudentPages());
      } else if (temp is ErrorModel) {
        emit(ErrorStudentPages());
      } else if (temp is ExceptionStudentPages) {
        emit(ExceptionStudentPages());
      }
    });
  }
}
