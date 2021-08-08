part of 'latestsong_bloc.dart';

@immutable
abstract class LatestsongEvent {}

class LatestsongChangeEvent extends LatestsongEvent {
  LatestsongChangeEvent();
}

class LatestsongStartToFetchEvent extends LatestsongEvent {}

class LatestsongSyncNowEvent extends LatestsongEvent {}
