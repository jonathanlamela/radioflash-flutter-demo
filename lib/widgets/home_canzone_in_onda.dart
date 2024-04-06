import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/tracking_item.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/widgets/loading_progress.dart';

class HomeCanzoneInOnda extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentList =
        ref.watch(playerStatusProvider.select((value) => value.currentList));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                "Ora in onda",
                textScaler: MediaQuery.of(context).textScaler,
                style: context.ultimiSuonatiPlaylistTextStyle(),
              )
            ],
          ),
        ),
        Container(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                    child: currentList.isNotEmpty
                        ? SongInfo(item: currentList.first)
                        : LoadingProgress(),
                    duration: Duration(milliseconds: 800)),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SongInfo extends StatelessWidget {
  const SongInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TrackItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      key: ValueKey(item.title),
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            child: Container(
                margin: EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: FittedBox(
                    child: item.cover,
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: context.canzoneInOndaDecoration()),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title,
                    overflow: TextOverflow.ellipsis,
                    style: context.oraInOndaSongTitle()),
                Text(
                  item.artist,
                  overflow: TextOverflow.ellipsis,
                  style: context.oraInOndaSongArtist(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
