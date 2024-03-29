// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'export_pages_bloc.dart';

@immutable
sealed class exportPagesEvent {}

// ignore: must_be_immutable
class exportPages extends exportPagesEvent {
  BuildContext context;
  exportPages({
    required this.context,
  });
}
