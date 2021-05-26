import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/PlayerProvider.dart';

import '../../../RadioMeta.dart';

class WebRadioChooseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = PageController(
        initialPage: Provider.of<PlayerProvider>(context, listen: false)
            .currentPlaylistIndex);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "SELEZIONA WEB RADIO",
                style: TextStyle(
                    fontFamily: GoogleFonts.quicksand().fontFamily,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
                    IconButton(
                      icon: Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.previousPage(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut);
                      },
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          Provider.of<PlayerProvider>(context, listen: false)
                              .changePlaylist(value);
                        },
                        children: List.generate(
                          playlist.length,
                          (index) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset("images/playlist/" +
                                          playlist[index]["logoUrl"]!),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      playlist[index]["etichettaCompleta"]!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.anton().fontFamily),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut);
                      },
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
