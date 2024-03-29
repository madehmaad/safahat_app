part of 'done_page_bloc.dart';

@immutable
sealed class enterdonePageState {}

final class enterdonePageInitial extends enterdonePageState {}

class SuccessenterdonePage extends enterdonePageState {}

// ignore: must_be_immutable
class ErrorenterdonePage extends enterdonePageState {}

// ignore: must_be_immutable
class ExcptionenterdonePage extends enterdonePageState {}

class LoadingToenterdonePage extends enterdonePageState {}

class DonedonePage extends enterdonePageState {}
