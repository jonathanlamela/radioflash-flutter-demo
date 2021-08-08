part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigationPageChangedEvent extends NavigationEvent {
  final int currentPage;

  NavigationPageChangedEvent({this.currentPage = 0});
}
