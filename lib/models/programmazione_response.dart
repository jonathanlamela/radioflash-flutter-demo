import 'package:radioflash/models/program_item.dart';

class ProgrammazioneResponse {
  late ProgramItem now;
  List<ProgramItem> todays = [];

  ProgrammazioneResponse();
  factory ProgrammazioneResponse.fromJson(Map<String, dynamic> json) {
    ProgrammazioneResponse item = ProgrammazioneResponse();

    item.now = ProgramItem.fromJson(json["now"]);

    item.todays = json["todayPrograms"]
        .cast<Map<String, dynamic>>()
        .map<ProgramItem>((e) => ProgramItem.fromJson(e))
        .toList();

    return item;
  }
}
