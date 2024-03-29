part of 'enter_page_bloc.dart';

@immutable
sealed class enterPageState {}

final class enterPageInitial extends enterPageState {}

class SuccessenterPage extends enterPageState {}

// ignore: must_be_immutable
class ErrorenterPage extends enterPageState {}

// ignore: must_be_immutable
class ExcptionenterPage extends enterPageState {}

class LoadingToenterPage extends enterPageState {}

class Donepage extends enterPageState {}
class Blocked extends enterPageState {}
