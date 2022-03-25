import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/models/PlayerStatus.dart';
import 'package:radioflash/models/classifica_state.dart';
import 'package:radioflash/providers/classifica_provider.dart';
import 'package:radioflash/providers/navigation_provider.dart';
import 'package:radioflash/providers/player_provider.dart';

final playerStatusProvider =
    StateNotifierProvider<PlayerProvider, PlayerStatus>(
        (ref) => PlayerProvider(ref));

final classificaProvider =
    StateNotifierProvider<ClassificaProvider, ClassificaState>(
        (ref) => ClassificaProvider(ref));

final navigationProvider = StateNotifierProvider<NavigationProvider, int>(
    (ref) => NavigationProvider(ref));
