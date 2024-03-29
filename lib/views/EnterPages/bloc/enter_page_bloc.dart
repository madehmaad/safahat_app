import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pages_app/core/domain/Service/enterPage/enter_page_service.dart';
import 'package:pages_app/core/domain/model/Model.dart';
import 'package:pages_app/core/domain/model/blocked_model.dart';
import 'package:pages_app/core/domain/model/done_page_model.dart';
import 'package:pages_app/core/domain/model/failed_entered_page.dart';
import 'package:pages_app/core/domain/model/success_enterd_page.dart';

part 'enter_page_event.dart';
part 'enter_page_state.dart';

class enterPageBloc extends Bloc<enterPageEvent, enterPageState> {
  enterPageBloc() : super(enterPageInitial()) {
    on<enterPage>((event, emit) async {
      emit(LoadingToenterPage());
      Model temp = await PageService().addPages(
          pages: event.page,
          frompage: event.frompage,
          topage: event.topage,
          name: event.name);

      if (temp is scucessEnteredPageModel) {
        emit(SuccessenterPage());
      } else if (temp is donePageModel) {
        emit(Donepage());
      } else if (temp is BlockedModel) {
        emit(Blocked());
      } else if (temp is failedEnterdModel) {
        emit(ErrorenterPage());
      } else {
        emit(ExcptionenterPage());
      }
    });
  }
}
