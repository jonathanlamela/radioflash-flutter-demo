import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/models/onair_state.dart';
import 'package:radioflash/models/player_status.dart';
import 'package:radioflash/providers/navigation_provider.dart';
import 'package:radioflash/providers/onairprogram_provider.dart';
import 'package:radioflash/providers/player_provider.dart';

final playerStatusProvider =
    StateNotifierProvider<PlayerProvider, PlayerStatus>(
        (ref) => PlayerProvider(ref));

final navigationProvider = StateNotifierProvider<NavigationProvider, int>(
    (ref) => NavigationProvider(ref));

final onAirProvider = StateNotifierProvider<OnAirProgramProvider, OnAirState>(
    (ref) => OnAirProgramProvider(ref));
