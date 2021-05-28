import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/UltimiSuonatiList.dart';

import "../../../ThemeConfig.dart";
import '../../../services/OnAirLatestSongProvider.dart';

class UltimiSuonatiInOnda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.2))),
          child: Row(
            children: [
              Text("ULTIMI SUONATI",
                  style: context.ultimiSuonatiInOndaTextStyle())
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<OnAirLatestSongProvider>(
                builder: (context, value, child) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: value.currentList.isNotEmpty
                        ? UltimiSuonatiList(
                            key: UniqueKey(),
                            items: value.currentList
                                .where((element) => element.isSong == true)
                                .toList()
                                .skip(1)
                                .take(6))
                        : LoadingProgress(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
