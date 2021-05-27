import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/PlayerProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/UltimiSuonatiList.dart';

class UltimiSuonatiPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            children: [
              Text("ULTIMI SUONATI",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Consumer<PlayerProvider>(
                    builder: (context, value, child) {
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
