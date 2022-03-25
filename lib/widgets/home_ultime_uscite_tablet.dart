import 'package:flutter/material.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:radioflash/widgets/loading_progress.dart';
import 'package:radioflash/widgets/home_ultime_uscite.dart';
import 'package:radioflash/widgets/home_ultime_uscite_list_tablet.dart';

class HomeUltimeUsciteTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
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
          child: Container(
              child: FutureBuilder(
            future: fetchUltimeUscite(ultimeUsciteLink),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: snapshot.hasData
                    ? HomeUltimeUsciteListTablet(
                        items: (snapshot.data as List<NewSongRelease>)
                            .where((element) => element.cover != null)
                            .take(6)
                            .toList(),
                      )
                    : LoadingProgress(),
              );
            },
          )),
        ),
      ],
    );
  }
}
