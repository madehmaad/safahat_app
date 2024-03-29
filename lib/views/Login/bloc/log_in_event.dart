part of 'log_in_bloc.dart';

@immutable
sealed class LogInEvent {}

// ignore: must_be_immutable
class Login extends LogInEvent {}
