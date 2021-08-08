import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/bloc/player_bloc.dart';

import '../../../RadioMeta.dart';
import '../../../ThemeConfig.dart';

class WebRadioChooseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = PageController(
        viewportFraction: 0.5,
        initialPage: context.watch<PlayerBloc>().currentPlaylistIndex);

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
                          context
                              .read<PlayerBloc>()
                              .add(PlayerChangePlaylistEvent(value));
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
