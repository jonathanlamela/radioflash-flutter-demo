part of 'classifica_bloc.dart';

@immutable
abstract class ClassificaState {
  List<String> Anni = [];
}

class ClassificaInitial extends ClassificaState {}

class ClassificaResultsState extends ClassificaState {
  List<Classifica> Results = [];
  Classifica? selected;
  ClassificaResultsState(this.Results, {this.selected});
}
