part of 'classifica_bloc.dart';

@immutable
abstract class ClassificaEvent {}

class ClassificaAnnoChangedEvent extends ClassificaEvent {
  String Anno;

  ClassificaAnnoChangedEvent(this.Anno);
}

class ClassificaSelectionChangedEvent extends ClassificaEvent {
  Classifica Selected;
  List<Classifica> Classifiche;
  ClassificaSelectionChangedEvent(this.Classifiche, this.Selected);
}
