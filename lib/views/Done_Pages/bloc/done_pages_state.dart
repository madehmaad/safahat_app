part of 'done_pages_bloc.dart';

@immutable
sealed class DonePagesState {}

final class DonePagesInitial extends DonePagesState {}

class SuccessDonePage extends DonePagesState {}

class ErrorDonePage extends DonePagesState {}

class LoadingToDonePage extends DonePagesState {}

class ExceptionDonePage extends DonePagesState {}
