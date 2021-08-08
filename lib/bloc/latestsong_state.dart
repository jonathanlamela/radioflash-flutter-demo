part of 'latestsong_bloc.dart';

@immutable
abstract class LatestsongState {
  List<TrackItem> currentList = [];
}

class LatestsongInitial extends LatestsongState {}

class LatestsongChangeState extends LatestsongState {
  List<TrackItem> currentList = [];

  LatestsongChangeState(this.currentList);
}
