import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationProvider extends StateNotifier<int> {
  final Ref ref;
  NavigationProvider(this.ref) : super(0);

  void selectedItem(int value) {
    this.state = value;
  }
}
