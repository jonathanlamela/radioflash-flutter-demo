import 'package:radioflash/models/Classifica.dart';

class ClassificaState {
  final List<String>? anni;
  final List<Classifica>? items;
  final Classifica? selected;
  final String? currentYear;

  ClassificaState(
      {required this.anni,
      required this.items,
      required this.selected,
      required this.currentYear});

  ClassificaState copyWith(
      {List<String>? anni,
      List<Classifica>? items,
      Classifica? selected,
      String? currentYear}) {
    return ClassificaState(
        anni: anni ?? this.anni,
        items: items ?? this.items,
        selected: selected ?? this.selected,
        currentYear: currentYear ?? this.currentYear);
  }
}
