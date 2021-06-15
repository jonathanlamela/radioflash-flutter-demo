import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/ProgramItem.dart';
import 'package:radioflash/services/OnAirProgramProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/RadioSize.dart';

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
                    (index == indexActive
                        ? OnAirAnimation(
                            controller: _controller, background: background)
                        : Container()),
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

class OnAirAnimation extends StatelessWidget {
  const OnAirAnimation({
    Key? key,
    required AnimationController controller,
    required this.background,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Animatable<Color?> background;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.redAccent[700],
            width: 100,
            margin: EdgeInsets.only(
              right: 10,
              top: 10,
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_input_antenna,
                  color: background.evaluate(
                    AlwaysStoppedAnimation(
                      _controller.value,
                    ),
                  ),
                  size: 24,
                ),
                Text(
                  "ON AIR",
                  style: TextStyle(
                    fontSize: 12,
                    color: background.evaluate(
                      AlwaysStoppedAnimation(_controller.value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
