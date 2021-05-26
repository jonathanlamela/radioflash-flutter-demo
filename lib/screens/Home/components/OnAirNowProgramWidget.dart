import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/models/ProgramItem.dart';
import 'package:radioflash/services/OnAirProgramProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:velocity_x/velocity_x.dart';

class OnAirNowProgramWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnAirNowProgramWidgetState();
  }
}

class OnAirNowProgramWidgetState extends State<OnAirNowProgramWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Animatable<Color?> background = TweenSequence<Color?>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.white,
          end: Colors.red,
        ),
      ),
    ],
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<OnAirProgramProvider>(
      builder: (context, value, child) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: value.currentList.isNotEmpty
                ? ProgrammazioneSlider(
                    key: UniqueKey(),
                    nowProgram: value.nowProgram!,
                    items: value.currentList,
                    controller: _controller,
                    background: background)
                : LoadingProgress());
      },
    );

    return consumer;
  }
}

class ProgrammazioneSlider extends StatelessWidget {
  const ProgrammazioneSlider(
      {Key? key,
      required AnimationController controller,
      required this.background,
      required this.items,
      required this.nowProgram})
      : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Animatable<Color?> background;
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

    return VxSwiper.builder(
      isFastScrollingEnabled: true,
      enlargeCenterPage: true,
      aspectRatio: (MediaQuery.of(context).size.width > 700 ? 16 / 9 : 1.5),
      initialPage: indexActive,
      itemCount: items.length,
      itemBuilder: (context, index) {
        var programma = items.elementAt(index);
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: programma.copertina!.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  programma.titolo.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  programma.speaker.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.anton().fontFamily,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${DateFormat('H:mm').format(programma.orarioInizio!)}-${DateFormat('H:mm').format(programma.orarioFine!)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (index == indexActive
                          ? AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.settings_input_antenna,
                                            color: background.evaluate(
                                              AlwaysStoppedAnimation(
                                                _controller.value,
                                              ),
                                            ),
                                            size: 28,
                                          ),
                                          Text(
                                            "ON AIR",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: background.evaluate(
                                                AlwaysStoppedAnimation(
                                                    _controller.value),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            )
                          : Container())
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
