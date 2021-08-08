import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioflash/bloc/player_bloc.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/UltimiSuonatiList.dart';
import '../../../ThemeConfig.dart';

class UltimiSuonatiPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, value) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: value.currentList.isNotEmpty
                        ? UltimiSuonatiList(
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
