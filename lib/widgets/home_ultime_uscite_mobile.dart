import 'package:flutter/material.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/new_song_release.dart';
import 'package:radioflash/widgets/loading_progress.dart';
import 'package:radioflash/widgets/home_ultime_uscite.dart';
import 'package:radioflash/widgets/home_ultime_uscite_list_mobile.dart';

class HomeUltimeUsciteMobile extends StatelessWidget {
  const HomeUltimeUsciteMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
                "Novità RadioFlash",
                style: context.novitaTextStyle(),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: context.novitaCardColor(),
                borderOnForeground: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    child: FutureBuilder(
                      future: fetchUltimeUscite(ultimeUsciteLink),
                      builder: (context, snapshot) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 600),
                          child: snapshot.hasData
                              ? HomeUltimeUsciteListMobile(
                                  items: (snapshot.data as List<NewSongRelease>)
                                      .where((element) => element.cover != null)
                                      .toList())
                              : LoadingProgress(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
