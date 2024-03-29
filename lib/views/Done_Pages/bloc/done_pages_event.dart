// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'done_pages_bloc.dart';

// @immutable
sealed class DonePagesEvent {}

class DonePages extends DonePagesEvent {
  String groupName;
  String studentName;
  DonePages({
    required this.groupName,
    required this.studentName,
  });
}
