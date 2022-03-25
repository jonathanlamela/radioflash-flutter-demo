import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:radioflash/provider.dart';

import '../../../RadioMeta.dart';
import '../../../ThemeConfig.dart';

class WebRadioChooseWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPlayListIndex = ref.watch(
        playerStatusProvider.select((value) => value.currentPlaylistIndex));
    var controller = PageController(
        viewportFraction: 0.5, initialPage: currentPlayListIndex);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SELEZIONA WEB RADIO",
                style: context.selezionaWebRadioTextStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          ref
                              .read(playerStatusProvider.notifier)
                              .changePlaylist(value);
                        },
                        children: List.generate(
                          playlist.length,
                          (index) {
                            return WebRadioItemWidget(
                              playlistitem: playlist[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WebRadioItemWidget extends StatelessWidget {
  final playlistitem;
  const WebRadioItemWidget({Key? key, required this.playlistitem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Image.asset("images/playlist/" + playlistitem["logoUrl"]!),
          ),
        ),
      ],
    );
  }
}
