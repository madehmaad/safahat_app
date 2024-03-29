part of 'export_pages_bloc.dart';

@immutable
sealed class exportPagesState {}

final class exportPagesInitial extends exportPagesState {}

class SuccesseexportPages extends exportPagesState {}

// ignore: must_be_immutable
class ErrorexportPages extends exportPagesState {}

// ignore: must_be_immutable
class ExcptionexportPages extends exportPagesState {}

class LoadingToexportPages extends exportPagesState {}


