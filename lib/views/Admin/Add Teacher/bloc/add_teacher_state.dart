part of 'add_teacher_bloc.dart';

@immutable
sealed class addteacherState {}

final class addteacherInitial extends addteacherState {}

class Successaddteacher extends addteacherState {}

// ignore: must_be_immutable
class Erroraddteacher extends addteacherState {}

// ignore: must_be_immutable
class Excptionaddteacher extends addteacherState {}

class LoadingToaddteacher extends addteacherState {}



