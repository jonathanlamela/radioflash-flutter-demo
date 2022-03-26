import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/program_item.dart';
import 'package:radioflash/widgets/home_onair_animation.dart';
import 'package:radioflash/widgets/radiosize.dart';

class ProgrammazioneSlider extends StatelessWidget {
  const ProgrammazioneSlider(
      {Key? key, required this.items, required this.nowProgram})
      : super(key: key);

  final List<ProgramItem> items;
  final ProgramItem nowProgram;

  @override
  Widget build(BuildContext context) {
    var indexActive = 0;

    var index = 0;
    items.forEach((element) {
      if (element.titolo == nowProgram.titolo &&
          element.orarioInizio == nowProgram.orarioInizio) {
        indexActive = index;
      }
      index++;
    });

    var pageViewController = PageController(
        initialPage: indexActive,
        viewportFraction: getSliderViewportFraction(context));

    return PageView.builder(
      controller: pageViewController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        var programma = items.elementAt(index);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: context.onAirContainerStyle(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: programma.copertina!.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    (index == indexActive ? OnAirAnimation() : Container()),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(programma.titolo,
                            style: context.programTitleStyle()),
                      ),
                      Container(
                        child: Text(programma.speaker,
                            style: context.programSpeakerStyle()),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        color: Colors.redAccent[700],
                        child: Text(
                            "${DateFormat('H:mm').format(programma.orarioInizio!)}-${DateFormat('H:mm').format(programma.orarioFine!)}",
                            style: context.programOrariStyle()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
