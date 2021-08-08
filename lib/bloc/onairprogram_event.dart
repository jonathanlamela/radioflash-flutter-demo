part of 'onairprogram_bloc.dart';

@immutable
abstract class OnairprogramEvent {}

class OnairprogramStartToFetchEvent extends OnairprogramEvent {}

class OnairprogramChangedEvent extends OnairprogramEvent {}

class OnairprogramSyncNowEvent extends OnairprogramEvent {}
