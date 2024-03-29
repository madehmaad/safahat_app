import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/enterPage/enter_page_service.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/done_page_model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_enterd_page.dart';

part 'done_page_event.dart';
part 'done_page_state.dart';

class enterdonePageBloc extends Bloc<donePageEvent, enterdonePageState> {
  enterdonePageBloc() : super(enterdonePageInitial()) {
    on<enterdonePage>((event, emit) async {
      emit(LoadingToenterdonePage());
      bool temp = await PageService().adddonePages(
          pages: event.page,
         );

      if (temp ) {
        emit(SuccessenterdonePage());
      // } else if (temp is donePageModel) {
      //   emit(Donepage());
      } else if (temp is failedEnterdModel) {
        emit(ErrorenterdonePage());
      } else {
        emit(ExcptionenterdonePage());
      }
    });
  }
}
