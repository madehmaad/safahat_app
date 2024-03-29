part of 'add_student_bloc.dart';

@immutable
sealed class add_studentState {}

final class add_studentInitial extends add_studentState {}

class Successadd_student extends add_studentState {}

// ignore: must_be_immutable
class Erroradd_student extends add_studentState {}

// ignore: must_be_immutable
class Excptionadd_student extends add_studentState {}

class LoadingToadd_student extends add_studentState {}



