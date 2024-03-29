// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_student_bloc.dart';

@immutable
sealed class add_studentEvent {}

// ignore: must_be_immutable
class add_student extends add_studentEvent {
  Map<String, dynamic> student;
  add_student({
    required this.student,
  });
}
