// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'enter_page_bloc.dart';

@immutable
sealed class enterPageEvent {}

// ignore: must_be_immutable
class enterPage extends enterPageEvent {
  List<Map<String, dynamic>> page;
  int frompage;
  int topage;
  String name;
  enterPage({
    required this.page,
    required this.frompage,
    required this.topage,
    required this.name,
  });
}
