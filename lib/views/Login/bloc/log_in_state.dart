part of 'log_in_bloc.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

class SuccessInLogin extends LogInState {}

// ignore: must_be_immutable
class ErrorInLogin extends LogInState {
  ErrorModel error;
  ErrorInLogin({required this.error});
}

// ignore: must_be_immutable
class ExcptionInLogin extends LogInState {
  List<ExceptionModel> excption;
  ExcptionInLogin({required this.excption});
}

class LoadingToLogin extends LogInState {}