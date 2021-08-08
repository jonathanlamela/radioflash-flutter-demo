part of 'onairprogram_bloc.dart';

@immutable
abstract class OnairprogramState {
  List<ProgramItem> currentList = [];
  ProgramItem? nowProgram;
}

class OnairprogramInitial extends OnairprogramState {}

class OnAirprogramChangeState extends OnairprogramState {
  List<ProgramItem> currentList = [];
  ProgramItem? nowProgram;

  OnAirprogramChangeState({required this.currentList, this.nowProgram});
}
