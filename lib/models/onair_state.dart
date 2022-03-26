import 'package:radioflash/models/program_item.dart';

class OnAirState {
  final List<ProgramItem> currentList;
  final ProgramItem? nowProgram;

  OnAirState(this.currentList, this.nowProgram);
}
