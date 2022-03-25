import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/UltimiSuonatiList.dart';
import '../../../ThemeConfig.dart';

class UltimiSuonatiPlaylist extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentList =
        ref.watch(playerStatusProvider.select((value) => value.currentList));
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.2))),
          child: Row(
            children: [
              Text(
                "Ultimi suonati",
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                style: context.ultimiSuonatiPlaylistTextStyle(),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: currentList.isNotEmpty
                    ? UltimiSuonatiList(
                        items: currentList
                            .where((element) => element.isSong == true)
                            .toList()
                            .skip(1)
                            .take(6))
                    : LoadingProgress(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
