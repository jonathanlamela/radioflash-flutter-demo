part of 'annoclassifica_cubit.dart';

@immutable
abstract class AnnoClassificaState {}

class AnnoclassificaInitial extends AnnoClassificaState {
  List<String> Anni = [];
  String? Selected;
}

class AnnoClassificaUpdateState extends AnnoClassificaState {
  List<String> Anni = [];
  String? Selected;

  AnnoClassificaUpdateState(this.Anni, {this.Selected});
}
