// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_teacher_bloc.dart';

@immutable
sealed class addteacherEvent {}

// ignore: must_be_immutable
class addteacher extends addteacherEvent {
  Map<String, dynamic> teacher;
  addteacher({
    required this.teacher,
  });
}
