part of 'student_pages_bloc.dart';

@immutable
sealed class StudentPagesState {}

final class StudentPagesInitial extends StudentPagesState {}

class SuccessStudentPages extends StudentPagesState {}

class ErrorStudentPages extends StudentPagesState {}

class LoadingToStudentPages extends StudentPagesState {}

class ExceptionStudentPages extends StudentPagesState {}
