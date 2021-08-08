part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  int currentPage = 0;
}

class NavigationInitial extends NavigationState {}

class NavigationPageState extends NavigationState {
  final int currentPage;
  NavigationPageState({this.currentPage = 0});
}
