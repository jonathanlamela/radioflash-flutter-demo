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
  TextStyle oraInOndaTextStyle() =>
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle oraInOndaSongTitle() => TextStyle(
        color: Colors.white,
      );
  TextStyle oraInOndaSongArtist() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  //CLASSIFICA
  TextStyle classificaTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  BoxDecoration classificaCoverDecoration() => BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.white.withOpacity(0.5))
        ],
      );

  TextStyle classificaSongTitleTextStyle() => TextStyle(
        color: Colors.white,
      );

  TextStyle classificaSongAuthorsTextStyle() => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      );

  TextStyle classificaMoreButtonTextStyle() => TextStyle(color: Colors.white);

  Color classificaMoreButtonIconColor() => Colors.white;

  TextStyle classificaTitoloTextStyle() => TextStyle(
        color: Colors.white,
      );

  TextStyle classificaNumeroTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
      );

  //HITS RADIO
  TextStyle hitsTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

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
      );

  TextStyle programSpeakerStyle() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle programOrariStyle() => TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  //NOVITà
  TextStyle novitaTextStyle() =>
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);

  Color novitaCardColor() => Colors.white70;
  Color ultimeUsciteContainerColor() => themePrimary();
  TextStyle ultimeUsciteTitleTextStyle() => TextStyle(
        color: Colors.white,
      );
  TextStyle ultimeUsciteArtistTextStyle() => TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.anton().fontFamily);
  TextStyle ultimeUsciteRadioDateTextStyle() => TextStyle(
        color: Colors.white,
        fontSize: 12,
      );
  TextStyle ultimeUsciteTabletTitleTextStyle() => TextStyle(
        color: Colors.white,
      );
  TextStyle ultimeUsciteTabletArtistTextStyle() => TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  Color ultimeUsciteOggiChipColor() => Colors.red[700]!;
  TextStyle ultimeUsciteChipTextStyle() => TextStyle(color: Colors.white);
  TextStyle ultimeUsciteTabletRadioDateTextStyle() =>
      TextStyle(color: Colors.white);

  TextStyle ultimiSuonatiInOndaTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle ultimiSuonatiTitleTextStyle() => TextStyle(color: Colors.white);

  TextStyle ultimiSuonatiArtistTextStyle() =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16);

  TextStyle ultimiSuonatiMinutiFaTextStyle() => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 10,
      );

  //APPCONTAINER
  Color statusBarColor() => Colors.transparent;
  Color gradientStartColor() => Colors.red[900]!;
  Color gradiendEndColor() => Colors.black;
  Color scaffoldBackgroundColor() => Color.fromARGB(100, 41, 31, 31);
  Color bottomNavSelectedItemColor() => Colors.red[900]!;
  Color bottomNavUnselectedItemColor() => Colors.black;
  TextStyle bottomNavTextStyle() => TextStyle(color: Colors.black);
  TextStyle bottomNavSelectedTextStyle() =>
      TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

  //RADIO PAGE
  Color radioContainerColor() => Colors.black87;
  TextStyle selezionaWebRadioTextStyle() =>
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle ultimiSuonatiPlaylistTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle ultimeNotizieTextStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  //PLAYLIST ITEM
  TextStyle playlistItemTitleTextStyle() => TextStyle(
        color: Colors.white,
      );
  TextStyle playlistItemArtistTextStyle() =>
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  BoxShadow shadownForDark() =>
      BoxShadow(blurRadius: 5, color: Colors.white.withOpacity(0.5));
}
