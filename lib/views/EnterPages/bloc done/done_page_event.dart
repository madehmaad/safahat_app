// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'done_page_bloc.dart';

@immutable
sealed class donePageEvent {}

// ignore: must_be_immutable
class enterdonePage extends donePageEvent {
  List<Map<String, dynamic>> page;
  
  enterdonePage({
    required this.page,
   
  });
}
