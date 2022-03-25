import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/models/PlayerStatus.dart';
import 'package:radioflash/providers/player_status_provider.dart';

final playerStatusProvider =
    StateNotifierProvider<PlayerStatusProvider, PlayerStatus>(
        (state) => PlayerStatusProvider(state));
