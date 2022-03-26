import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/widgets/home_programmazione_slider.dart';

import 'package:radioflash/widgets/loading_progress.dart';

class HomeProgrammaInOndaWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var programmazione = ref.watch(onAirProvider);

    return AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: programmazione.currentList.isNotEmpty
            ? ProgrammazioneSlider(
                key: UniqueKey(),
                nowProgram: programmazione.nowProgram!,
                items: programmazione.currentList,
              )
            : LoadingProgress());
  }
}
