part of 'annoclassifica_cubit.dart';

@immutable
abstract class AnnoclassificaState {}

class AnnoclassificaInitial extends AnnoclassificaState {
  List<String> Anni = [];
  String? Selected;
}

class AnnoClassificaUpdateState extends AnnoclassificaState {
  List<String> Anni = [];
  String? Selected;

  AnnoClassificaUpdateState(this.Anni, {this.Selected});
}
