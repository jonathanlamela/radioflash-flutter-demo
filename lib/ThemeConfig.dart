import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeContext on BuildContext {
  logoImmagine() => Image.asset("images/logo.png", height: 60);
  String mainFontFamily() => GoogleFonts.quicksand().fontFamily!;
  Color themePrimary() => Colors.red[900]!;

  Color loadingProgressBackgroundColor() => Colors.transparent;
  Color loadingProgressColor() => Colors.white;

  //RADIOPLAYER
  Color playPauseButtonIconColor() => Colors.white;
  Color playPauseButtonColor() => Colors.grey.shade900;
  Color playlineBackgroundColor() => Colors.white;
  Color playlineValueColor() => themePrimary();
  Color playerBackgroundColor() => Colors.black;

  TextStyle playerSongTitleTextStyle() => TextStyle(
        color: Colors.white,
        fontSize: 12,
      );

  TextStyle playerSongArtistTextStyle() =>
      TextStyle(color: Colors.white, fontSize: 10);

  //HOME
  Color homeContainerColor() => Colors.black87;
  BoxDecoration homeContainerStyle() => BoxDecoration(
        color: homeContainerColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      );

  //CANZONE IN ONDA
  BoxDecoration canzoneInOndaDecoration() => BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.white),
        ],
      );
  TextStyle oraInOndaTextStyle() => TextStyle(
      fontFamily: mainFontFamily(),
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  TextStyle oraInOndaSongTitle() => TextStyle(
        color: Colors.white,
        fontFamily: mainFontFamily(),
      );
  TextStyle oraInOndaSongArtist() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: mainFontFamily(),
        fontWeight: FontWeight.bold,
      );

  //CLASSIFICA
  TextStyle classificaTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: mainFontFamily(),
      );

  BoxDecoration classificaCoverDecoration() => BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.white.withOpacity(0.5))
        ],
      );

  TextStyle classificaSongTitleTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());

  TextStyle classificaSongAuthorsTextStyle() => TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
      fontFamily: mainFontFamily());

  TextStyle classificaMoreButtonTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());

  Color classificaMoreButtonIconColor() => Colors.white;

  TextStyle classificaTitoloTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());

  TextStyle classificaNumeroTextStyle() => TextStyle(
      fontSize: 16, color: Colors.white, fontFamily: mainFontFamily());

  //HITS RADIO
  TextStyle hitsTextStyle() => TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: mainFontFamily());

  //ON AIR NOW PROGRAM
  Color onAirProgramContainerColor() => Colors.black87;
  BoxDecoration onAirContainerStyle() => BoxDecoration(
        color: onAirProgramContainerColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      );

  TextStyle programTitleStyle() => TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: mainFontFamily(),
      );

  TextStyle programSpeakerStyle() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: mainFontFamily(),
      );

  TextStyle programOrariStyle() => TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: mainFontFamily(),
      );

  //NOVITà
  TextStyle novitaTextStyle() => TextStyle(
      fontFamily: mainFontFamily(),
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  Color novitaCardColor() => Colors.white70;
  Color ultimeUsciteContainerColor() => themePrimary();
  TextStyle ultimeUsciteTitleTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());
  TextStyle ultimeUsciteArtistTextStyle() => TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.anton().fontFamily);
  TextStyle ultimeUsciteRadioDateTextStyle() => TextStyle(
      color: Colors.white, fontSize: 12, fontFamily: mainFontFamily());
  TextStyle ultimeUsciteTabletTitleTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());
  TextStyle ultimeUsciteTabletArtistTextStyle() => TextStyle(
        color: Colors.white,
        fontFamily: mainFontFamily(),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  Color ultimeUsciteOggiChipColor() => Colors.red[700]!;
  TextStyle ultimeUsciteChipTextStyle() => TextStyle(color: Colors.white);
  TextStyle ultimeUsciteTabletRadioDateTextStyle() =>
      TextStyle(fontFamily: mainFontFamily(), color: Colors.white);

  TextStyle ultimiSuonatiInOndaTextStyle() => TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: mainFontFamily());

  TextStyle ultimiSuonatiTitleTextStyle() =>
      TextStyle(fontFamily: mainFontFamily(), color: Colors.white);

  TextStyle ultimiSuonatiArtistTextStyle() => TextStyle(
      fontFamily: mainFontFamily(),
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16);

  TextStyle ultimiSuonatiMinutiFaTextStyle() => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 10,
        fontFamily: mainFontFamily(),
      );

  //APPCONTAINER
  Color statusBarColor() => Colors.transparent;
  Color gradientStartColor() => Colors.red[900]!;
  Color gradiendEndColor() => Colors.black;
  Color scaffoldBackgroundColor() => Color.fromARGB(100, 41, 31, 31);
  Color bottomNavSelectedItemColor() => Colors.red[900]!;
  Color bottomNavUnselectedItemColor() => Colors.black;
  TextStyle bottomNavTextStyle() =>
      TextStyle(color: Colors.black, fontFamily: mainFontFamily());
  TextStyle bottomNavSelectedTextStyle() => TextStyle(
      color: Colors.red,
      fontFamily: mainFontFamily(),
      fontWeight: FontWeight.bold);

  //RADIO PAGE
  Color radioContainerColor() => Colors.black87;
  TextStyle selezionaWebRadioTextStyle() => TextStyle(
      fontFamily: mainFontFamily(),
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  TextStyle ultimiSuonatiPlaylistTextStyle() => TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: mainFontFamily());

  //PLAYLIST ITEM
  TextStyle playlistItemTitleTextStyle() =>
      TextStyle(color: Colors.white, fontFamily: mainFontFamily());
  TextStyle playlistItemArtistTextStyle() => TextStyle(
      color: Colors.white,
      fontFamily: mainFontFamily(),
      fontSize: 16,
      fontWeight: FontWeight.bold);

  BoxShadow shadownForDark() =>
      BoxShadow(blurRadius: 5, color: Colors.white.withOpacity(0.5));
}
