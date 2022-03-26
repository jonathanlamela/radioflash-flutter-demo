import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/new_song_release.dart';

class HomeUltimeUsciteDetail extends StatelessWidget {
  const HomeUltimeUsciteDetail({Key? key, required this.item})
      : super(key: key);

  final NewSongRelease item;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          child: Container(
            color: Colors.transparent,
            height: 400,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: item.cover!.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: context.ultimeUsciteContainerColor(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.titolo,
                              style: context.ultimeUsciteTitleTextStyle(),
                            ),
                            Text(
                              item.artista,
                              style: context.ultimeUsciteArtistTextStyle(),
                            ),
                            Text(
                              DateFormat('d/MM/y').format(item.radioDate!),
                              style: context.ultimeUsciteRadioDateTextStyle(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
